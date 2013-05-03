class Plan < ActiveRecord::Base
  #default_scope :order => :old_id

  belongs_to :assortment
  attr_accessible :date, :day, :month, :assortment_id, :assortment
  after_update :check_plan
  after_update :summing

  def summing
    konf_all = Plan.where("MONTH(date) = 1 AND YEAR(date) = 2013", self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id IN (12, 13, 14, 6, 7, 8)").sum("month")
    #konf_all = Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("assortment.old_id IN (12, 13, 14, 6, 7, 8)").sum("month")
    kar_all = Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id IN (3, 4, 5, 9)").sum("month")
    drage = Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 15").first

    kar_all = kar_all.blank? ? 0 : kar_all
    konf_all = drage.blank? ? 0 : konf_all
    drage = drage.blank? ? 0 : drage

    all =  drage.month + konf_all + kar_all
    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 11").update_all(:month => konf_all, :day => konf_all / self.date.to_date.end_of_month.to_date.day)
    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 2").update_all(:month => kar_all, :day => kar_all / self.date.to_date.end_of_month.to_date.day)
    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 1").update_all(:month => all, :day => all / self.date.to_date.end_of_month.to_date.day)
  end

  def check_plan
    if self.month
      Asrt.where("MONTH(DAT) = ? AND YEAR(DAT) = ? AND N = ?", self.date.month, self.date.year, self.assortment.old_id).update_all(:PLM => self.month, :PLD => self.day)
    end
  end
end
