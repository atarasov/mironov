# encoding: utf-8
ActiveAdmin.register Assortment, {:sort_order => "old_id ASC"}  do
  #scope :today, :default => true do |plan|
  #  plan.order("old_id ASC")
  #end
  index do
    selectable_column
    column :name
    column :old_id

    default_actions
  end




  #collection_action :plan_create, :method => :put do
  #  user = User.find(params[:id])
  #  user.lock!
  #  redirect_to :action => :index#, :notice => "План создан!" #}, {:notice => "Locked!"}
  #end

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
