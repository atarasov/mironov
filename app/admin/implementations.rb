# encoding: utf-8
ActiveAdmin.register Implementation do

  scope :all

  scope :today, :default => true do |implementation|
    implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", Time.now.day, Time.now.month, Time.now.year)
  end

  index do
    #column :S
    column :N
    column :DAT
    #column :DN
    column :KOD
    column :NAIM
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
      #f.input :S
      #f.input :N
      f.input :DAT, :as => :datepicker
      #f.input :DN
      #f.input :KOD
      f.input :NAIM, :as => :select, :collection => Direction.all
      f.input :SUM
      #f.input :SUMM
      #f.input :SUMY
      #f.input :P
      #f.input :AWT


    end
    f.actions
  end

  before_save do |implementation|
    #implementation.N = params[:implementation][:NAIM]
    #implementation.NAIM = Direction.find(params[:implementation][:NAIM]).name
    #implementation.DN = params[:implementation][:DAT].to_date.day
    #if params[:implementation][:DAT].to_date.day ==  1
    #  implementation.SUMM = params[:implementation][:SUM].to_f
    #  if params[:implementation][:DAT].to_date.month ==  1
    #    implementation.SUMY = params[:implementation][:SUM].to_f
    #  else
    #    implementation.SUMY = Implementation.where("DAT = ? AND N = ?",params[:implementation][:DAT].to_date - 1.day, params[:implementation][:NAIM]).first.SUMM.to_f + params[:implementation][:SUM].to_f
    #  end
    #else
    #  implementation.SUMM = Implementation.where("DAT = ? AND N = ?",params[:implementation][:DAT].to_date - 1.day, params[:implementation][:NAIM]).first.SUMM.to_f + params[:implementation][:SUM].to_f
    #  implementation.SUMY = Implementation.where("DAT = ? AND N = ?",params[:implementation][:DAT].to_date - 1.day, params[:implementation][:NAIM]).first.SUMY.to_f + params[:implementation][:SUM].to_f
    #end
  end
end
