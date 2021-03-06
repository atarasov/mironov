# encoding: utf-8
ActiveAdmin.register Implementation, {:sort_order => "N ASC"} do

  scope :all

  scope :today do |implementation|
    implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", Time.now.day, Time.now.month, Time.now.year).order('N ASC')
  end

  scope :day2 do |implementation|
    implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 1.day).day, (Time.now - 1.day).month, (Time.now - 1.day).year).order('N ASC')
  end

  scope :day3 do |implementation|
    implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 2.day).day, (Time.now - 2.day).month, (Time.now - 2.day).year).order('N ASC')
  end

  scope :day4 do |implementation|
    implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 3.day).day, (Time.now - 3.day).month, (Time.now - 3.day).year).order('N ASC')
  end

  scope :day5 do |implementation|
    implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 4.day).day, (Time.now - 4.day).month, (Time.now - 4.day).year).order('N ASC')
  end

  scope :day6 do |implementation|
    implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 5.day).day, (Time.now - 5.day).month, (Time.now - 5.day).year).order('N ASC')
  end

  scope :day7 do |implementation|
    implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 6.day).day, (Time.now - 6.day).month, (Time.now - 6.day).year).order('N ASC')
  end

  sidebar :implementation_create

  index do
    selectable_column
    #column :S
    column :N
    #column :DN
    #column :KOD
    column :NAIM
    column :DAT do |implementation|
      Russian::strftime(implementation.DAT, "%d %B %Y")
    end
    column :DN
    #column :SUM
    #if can? :create, Implementation
    #  column(:SUM) { |i| best_in_place i,
    #                                   :SUM,
    #                                   :type => :input,
    #                                   :path => [:admin, i],
    #                                   :display_with => :number_to_currency,
    #                                   :helper_options => {:delimiter => " ",
    #                                                       :precision => 0,
    #                                                       :unit => ""}
    #  }
    #else
      column :SUM do |implementation|
        number_to_currency implementation.SUM, :delimiter => " ", :precision => 0, :unit => ""
      end
    #end
    column :SUMM do |implementation|
      number_to_currency implementation.SUMM, :delimiter => " ", :precision => 0, :unit => ""
    end
    column :SUMY do |implementation|
      number_to_currency implementation.SUMY, :delimiter => " ", :precision => 0, :unit => ""
    end
    #column :P
    #column :AWT
    if current_admin_user.super_admin?
      default_actions
    end
  end

  filter :year, :as => :select, :collection => (2008..Time.now.year.to_i)
  filter :month, :as => :select, :collection => (1..12)
  filter :day, :as => :select, :collection => (1..Time.now.end_of_month.day.to_i)


  form do |f|
    f.inputs "Реализация" do
      f.input :S
      f.input :N
      f.input :DAT, :as => :datepicker
      f.input :DN
      f.input :KOD
      f.input :NAIM, :as => :select, :collection => Direction.all
      f.input :SUM
      f.input :SUMM
      f.input :SUMY
      f.input :P
      f.input :AWT


    end
    f.actions
  end

  before_save do |implementation|
    implementation.N = params[:implementation][:NAIM] if params[:implementation][:NAIM]
    implementation.NAIM = Direction.find(params[:implementation][:NAIM]).name if params[:implementation][:NAIM]
    implementation.DN = params[:implementation][:DAT].to_date.day if params[:implementation][:DAT]
    #raise implementation.inspect

    #date = implementation.DAT
    #naim = params[:implementation][:NAIM]? params[:implementation][:NAIM] : implementation.N
    #
    #implementation.SUMM = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) <= ? AND N = ?",date.year, date.month, date.day, naim).sum("SUM")
    #implementation.SUMY = Implementation.where("YEAR(DAT) = ? AND DAY(DAT) <= ? AND N = ?",date.year, date.day, naim).sum("SUM")


    #if (params[:implementation] && params[:implementation][:DAT] && params[:implementation][:DAT].to_date.day ==  1) || implementation.DAT.to_date.day ==  1
    #  implementation.SUMM = params[:implementation][:SUM]? params[:implementation][:SUM].to_f : implementation.SUM.to_f
    #  if (params[:implementation] && params[:implementation][:DAT] && params[:implementation][:DAT].to_date.month ==  1) || implementation.DAT.to_date.month ==  1
    #    implementation.SUMY = params[:implementation][:SUM]? params[:implementation][:SUM].to_f : implementation.SUM.to_f
    #  else
    #    date = params[:implementation][:DAT]? params[:implementation][:DAT].to_date : implementation.DAT.to_date
    #    sum = params[:implementation][:SUM]? params[:implementation][:SUM].to_f : implementation.SUM.to_f
    #    naim = params[:implementation][:NAIM]? params[:implementation][:NAIM] : implementation.N
    #    implementation.SUMY = Implementation.where("DATE(DAT) = ? AND N = ?", date - 1.day, naim).first.SUMM.to_f + sum
    #  end
    #else
    #  date = params[:implementation][:DAT]? params[:implementation][:DAT].to_date : implementation.DAT.to_date
    #  sum = params[:implementation][:SUM].to_f #|| implementation.SUM.to_f
    #  naim = params[:implementation][:NAIM]? params[:implementation][:NAIM] : implementation.N
    #  #
    #  #if implementation && implementation.SUMM && implementation.SUMM
    #    #unless implementation.SUMM
    #    #raise implementation.inspect
    #    #end
    #  summ = .first
    #  if summ
    #    implementation.SUMM = summ.SUMM.to_f + sum
    #  else
    #
    #  implementation.SUMY = Implementation.where("DATE(DAT) = ? AND N = ?",date - 1.day, naim).first.SUMY.to_f + sum
    #  #end
    #end
  end
end
