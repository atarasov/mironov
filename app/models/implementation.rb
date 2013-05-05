class Implementation < ActiveRecord::Base
  self.table_name = 'RL'
  attr_accessible :S, :N, :DAT, :DN, :KOD, :NAIM, :SUM, :SUMM, :SUMY, :P, :AWT
  #field :KOD
  #field :NAIM
  #field :SUM
  #field :SUMM
  #field :SUMY
  #field :DAT

  after_update :sum_cor
  after_update :summing_sum
  after_update :summing_summ
  after_update :summing_sumy


  def sum_cor
    summ = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) <= ? AND N = ?",self.DAT.year, self.DAT.month, self.DAT.day, self.N).sum("SUM")
    sumy = Implementation.where("YEAR(DAT) = ? AND DAY(DAT) <= ? AND N = ?",self.DAT.year, self.DAT.day, self.N).sum("SUM")
    Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = ?",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day, self.N).update_all(:SUMY => sumy, :SUMM => summ )
  end


  def summing_sum
    ost_kam = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (17,18)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("SUM")
    ost_kam_summ = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (17,18)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("SUMM")
    ost_kam_sumy = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (17,18)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("SUMY")

    Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 16",
                         self.DAT.to_date.year,
                         self.DAT.to_date.month,
                         self.DAT.to_date.day).update_all(
        :SUMY => ost_kam_sumy,
        :SUM => ost_kam,
        :SUMM => ost_kam_summ
    )
  end

  def summing_summ
    rel_mokshan = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (3, 4)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("SUM")
    rel_mokshan_summ = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (3, 4)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("SUMM")
    rel_mokshan_sumy = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (3, 4)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("SUMY")

    Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 9",
                         self.DAT.to_date.year,
                         self.DAT.to_date.month,
                         self.DAT.to_date.day).update_all(
        :SUMY => rel_mokshan_sumy,
        :SUM => rel_mokshan,
        :SUMM => rel_mokshan_summ)

  end

  def summing_sumy
    rel_all = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (2, 3, 4, 5)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("SUM")
    rel_all_summ = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (2, 3, 4, 5)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("SUMM")
    rel_all_sumy = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (2, 3, 4, 5)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("SUMY")

    Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 1",
                         self.DAT.to_date.year,
                         self.DAT.to_date.month,
                         self.DAT.to_date.day).update_all(
        :SUMY => rel_all_sumy,
        :SUM => rel_all,
        :SUMM => rel_all_summ)

  end

end