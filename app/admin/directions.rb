# encoding: utf-8
ActiveAdmin.register Direction, {:sort_order => "old_id ASC"}  do
  index do
    selectable_column
    column :name
    column :old_id

    default_actions
  end

  #index :as => :grid, :columns => 5 do |assortment|
  #  link_to(assortment.name, admin_assortment_path(product))
  #end



  filter :name


  form do |f|
    f.inputs "Направление" do
      f.input :name
      f.input :old_id
    end
    f.actions

  end
  
end
