# encoding: utf-8

ActiveAdmin.register Balance do
  menu :parent => "Касса"
  index do
    column :DATA
    column :DAT
    column :RSUM
    column :S
    column :NAMEPO
    column :NAZN


    default_actions
  end

  filter :DATA
  filter :NAZN


  form do |f|
    f.inputs "Расходы" do
      f.input :DATA
      f.input :DAT, :as => :datepicker
      f.input :RSUM
      f.input :S
      f.input :NAMEPO
      f.input :NAZN
    end
    f.actions

 end
end
