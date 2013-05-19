
class Asrt < ActiveRecord::Base
  self.table_name = 'PL'


  attr_accessible :C, :DAT, :N, :KOD, :NAIM, :DN, :PLM, :PLS, :PLD, :VRY,
                  :VRS, :VRD, :OST, :OST1, :RLD, :NSS, :A1, :A2, :A3, :A4, :A5, :A6, :A7, :A8, :A9, :P, :AWT

  after_update :summing_ost
  after_update :summing_rld
  after_update :summing_vrd

  scope :year_eq, lambda{ |year| where("YEAR(DAT) = ?", year.to_i) }
  scope :month_eq, lambda{ |month| where("MONTH(DAT) = ?", month.to_i) }
  scope :day_eq, lambda{ |day| where("DAY(DAT) = ?", day.to_i) }

  search_methods :year_eq
  search_methods :month_eq
  search_methods :day_eq


  def summing_ost
    konf_all = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (12, 13, 14, 6, 7, 8)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("OST")
    konf_cex = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (12, 13, 14, 15)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("OST")
    kar_all = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (3, 4, 5, 9)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("OST")
    kar_cex = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (3, 4, 5, 6, 7, 8, 9)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("OST")
    sashe = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (14, 6, 7, 8)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("OST")
    perekrut = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (12, 13)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("OST")
    @drage = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 15",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).first

    #raise @drage.inspect

    if @drage.blank? || @drage.OST.blank?
      all = konf_all + kar_all
    else
      all =  @drage.OST + konf_all + kar_all
    end


    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 11",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:OST => konf_all)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 2",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:OST => kar_all)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 1",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:OST => all)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 19",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:OST => konf_cex)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 18",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:OST => kar_cex)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 16",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:OST => sashe)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 17",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:OST => perekrut)
  end

  def summing_vrd
    konf_all = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (12, 13, 14, 6, 7, 8)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("VRD")
    konf_cex = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (12, 13, 14, 15)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("VRD")
    kar_all = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (3, 4, 5, 9)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("VRD")
    kar_cex = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (3, 4, 5, 6, 7, 8, 9)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("VRD")
    sashe = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (14, 6, 7, 8)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("VRD")
    perekrut = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (12, 13)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("VRD")
    @drage = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 15",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).first

    #raise @drage.inspect

    if @drage.blank? || @drage.VRD.blank?
      all = konf_all + kar_all
    else
      all =  @drage.VRD + konf_all + kar_all
    end


    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 11",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:VRD => konf_all)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 2",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:VRD => kar_all)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 1",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:VRD => all)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 19",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:VRD => konf_cex)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 18",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:VRD => kar_cex)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 16",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:VRD => sashe)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 17",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:VRD => perekrut)
  end

  def summing_rld
    konf_all = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (12, 13, 14, 6, 7, 8)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("RLD")
    konf_cex = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (12, 13, 14, 15)", self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("RLD")
    kar_all = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (3, 4, 5, 9)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("RLD")
    kar_cex = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (3, 4, 5, 6, 7, 8, 9)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("RLD")
    sashe = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (14, 6, 7, 8)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("RLD")
    perekrut = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N IN (12, 13)",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).sum("RLD")
    @drage = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 15",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).first

    #raise @drage.inspect

    if @drage.blank? || @drage.RLD.blank?
      all = konf_all + kar_all
    else
      all =  @drage.RLD + konf_all + kar_all
    end


    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 11",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:RLD => konf_all)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 1",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:RLD => all)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 19",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:RLD => konf_cex)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 18",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:RLD => kar_cex)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 16",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:RLD => sashe)
    Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = 17",self.DAT.to_date.year, self.DAT.to_date.month, self.DAT.to_date.day).update_all(:RLD => perekrut)
  end

end