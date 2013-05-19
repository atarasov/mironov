# encoding: utf-8
ActiveAdmin.register DbfFile do

  index do
    selectable_column
    column :plan
    column :implementation

    default_actions
  end

  #index :as => :grid, :columns => 5 do |assortment|
  #  link_to(assortment.name, admin_assortment_path(product))
  #end



  filter :name


  form do |f|
    f.inputs "PL.DBF" do
      f.input :plan
    end
    f.inputs "RL.DBF" do
      f.input :implementation
    end
    f.actions

  end
  
end
