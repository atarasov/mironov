# encoding: utf-8
ActiveAdmin.register Assortment do
  index do
    column :name
    column :old_id

    default_actions
  end

  #index :as => :grid, :columns => 5 do |assortment|
  #  link_to(assortment.name, admin_assortment_path(product))
  #end



  filter :name


  form do |f|
    f.inputs "Ассортимент" do
      f.input :name
      f.input :old_id
    end
    f.actions

  end
end
