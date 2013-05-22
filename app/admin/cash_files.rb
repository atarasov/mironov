ActiveAdmin.register CashFiles do
  index do
    selectable_column
    column :cash
    column :cashc
    column :balance

    default_actions
  end

  #index :as => :grid, :columns => 5 do |assortment|
  #  link_to(assortment.name, admin_assortment_path(product))
  #end



  filter :name


  form do |f|
    f.inputs "KS.DBF" do
      f.input :cash
    end
    f.inputs "KC.DBF" do
      f.input :cashc
    end
    f.inputs "TARX.DBF" do
      f.input :balance
    end
    f.actions

  end
  
end
