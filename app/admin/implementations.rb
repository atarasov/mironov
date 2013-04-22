# encoding: utf-8
ActiveAdmin.register Implementation do

  index do
    column :S
    column :N
    column :DAT
    column :DN
    column :KOD
    column :NAIM
    column :SUM
    column :SUMM
    column :SUMY
    column :P
    column :AWT

    default_actions
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
      f.input :NAIM#, :as => :select, :collection => Assortment.all
      f.input :SUM
      f.input :SUMM
      f.input :SUMY
      f.input :P
      f.input :AWT


    end
    f.actions
  end
end
