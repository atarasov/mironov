# encoding: utf-8
ActiveAdmin.register Quantity do
    index do
      column :kol
      column :date

      default_actions
    end

    #index :as => :grid, :columns => 5 do |assortment|
    #  link_to(assortment.name, admin_assortment_path(product))
    #end



    filter :name


    form do |f|
      f.inputs "Численность" do
        f.input :kol
        f.input :date, :as => :datepicker
      end
      f.actions

    end

  end
