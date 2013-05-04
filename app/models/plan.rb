class Plan < ActiveRecord::Base
  #default_scope :order => :old_id

  belongs_to :assortment
  attr_accessible :date, :day, :month, :assortment_id, :assortment
  after_update :check_plan
  after_update :summing

  def summing
    konf_all = Plan.where("YEAR(date) = ? AND MONTH(date) = ?", self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id IN (12, 13, 14, 6, 7, 8)").sum("month")
    konf_cex = Plan.where("YEAR(date) = ? AND MONTH(date) = ?", self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id IN (12, 13, 14, 15)").sum("month")
    #konf_all = Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("assortment.old_id IN (12, 13, 14, 6, 7, 8)").sum("month")
    kar_all = Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id IN (3, 4, 5, 9)").sum("month")
    kar_cex = Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id IN (3, 4, 5, 6, 7, 8, 9)").sum("month")
    sashe = Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id IN (14, 6, 7, 8)").sum("month")
    perekrut = Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id IN (12, 13)").sum("month")
    @drage = Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 15").first

    #raise @drage.inspect

    if @drage.blank? || @drage.month.blank?
      all = konf_all + kar_all
    else
      all =  @drage.month + konf_all + kar_all
    end


    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 11").update_all(:month => konf_all, :day => konf_all / self.date.to_date.end_of_month.to_date.day)
    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 2").update_all(:month => kar_all, :day => kar_all / self.date.to_date.end_of_month.to_date.day)
    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 1").update_all(:month => all, :day => all / self.date.to_date.end_of_month.to_date.day)

    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 19").update_all(:month => konf_cex, :day => konf_cex / self.date.to_date.end_of_month.to_date.day)
    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 18").update_all(:month => kar_cex, :day => kar_cex / self.date.to_date.end_of_month.to_date.day)
    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 16").update_all(:month => sashe, :day => sashe / self.date.to_date.end_of_month.to_date.day)
    Plan.where("YEAR(date) = ? AND MONTH(date) = ?",self.date.to_date.year, self.date.to_date.month).joins(:assortment).where("old_id = 17").update_all(:month => perekrut, :day => perekrut / self.date.to_date.end_of_month.to_date.day)
  end

  def check_plan
    if self.month
      Asrt.where("MONTH(DAT) = ? AND YEAR(DAT) = ? AND N = ?", self.date.month, self.date.year, self.assortment.old_id).update_all(:PLM => self.month, :PLD => self.day)
    end
  end
end
