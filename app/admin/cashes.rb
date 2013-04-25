# encoding: utf-8
ActiveAdmin.register Cash do
  menu :parent => "Касса"

  index do
    column :N
    column :DAT
    column :KOD
    column :NAIM
    column :SUM
    column :BN1
    column :BN2
    column :BN3
    column :BN4
    column :BN5
    column :AWT
    column :BK1
    column :BK2
    column :BK3
    column :BK4
    column :BK5

    default_actions
  end

  filter :DAT
  filter :NAIM
  filter :BN2
  filter :BN1


  form do |f|
    f.inputs "Касса Виктория" do
      f.input :N
      f.input :DAT, :as => :datepicker
      f.input :KOD
      f.input :NAIM
      f.input :SUM
      f.input :BN1
      f.input :BN2
      f.input :BN3
      f.input :BN4
      f.input :BN5
      f.input :AWT
      f.input :BK1
      f.input :BK2
      f.input :BK3
      f.input :BK4
      f.input :BK5


    end
    f.actions
  end
end
