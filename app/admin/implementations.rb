# encoding: utf-8
ActiveAdmin.register Implementation, {:sort_order => "N ASC"} do

  scope :all

  scope :today, :default => true do |implementation|
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
    column :DAT
    column :DN
    #column :SUM
    column(:SUM) { |i| best_in_place i, :SUM, :type => :input, :path => [:admin, i] }
    column :SUMM
    column :SUMY
    #column :P
    #column :AWT
    if current_admin_user.super_admin?
      default_actions
    end
  end

  filter :DN
  filter :DAT
  filter :NAIM


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
    if (params[:implementation] && params[:implementation][:DAT] && params[:implementation][:DAT].to_date.day ==  1) || implementation.DAT.to_date.day ==  1
      implementation.SUMM = params[:implementation][:SUM]? params[:implementation][:SUM].to_f : implementation.SUM.to_f
      if (params[:implementation] && params[:implementation][:DAT] && params[:implementation][:DAT].to_date.month ==  1) || implementation.DAT.to_date.month ==  1
        implementation.SUMY = params[:implementation][:SUM]? params[:implementation][:SUM].to_f : implementation.SUM.to_f
      else
        date = params[:implementation][:DAT]? params[:implementation][:DAT].to_date : implementation.DAT.to_date
        sum = params[:implementation][:SUM]? params[:implementation][:SUM].to_f : implementation.SUM.to_f
        naim = params[:implementation][:NAIM]? params[:implementation][:NAIM] : implementation.N
        implementation.SUMY = Implementation.where("DATE(DAT) = ? AND N = ?", date - 1.day, naim).first.SUMM.to_f + sum
      end
    else
      date = params[:implementation][:DAT]? params[:implementation][:DAT].to_date : implementation.DAT.to_date
      sum = params[:implementation][:SUM].to_f #|| implementation.SUM.to_f
      naim = params[:implementation][:NAIM]? params[:implementation][:NAIM] : implementation.N
      implementation.SUMM = Implementation.where("DATE(DAT) = ? AND N = ?",date - 1.day, naim).first.SUMM.to_f + sum
      implementation.SUMY = Implementation.where("DATE(DAT) = ? AND N = ?",date - 1.day, naim).first.SUMY.to_f + sum
    end
  end
end
