# encoding: utf-8

ActiveAdmin.register Balance do

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
      f.input :DAT, :as => :date
      f.input :RSUM
      f.input :S
      f.input :NAMEPO
      f.input :NAZN
    end
    f.actions

 end
end
