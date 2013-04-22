# encoding: utf-8
ActiveAdmin.register AdminUser do
  #menu :if => proc{ can?(:manage, AdminUser) }
  index do
    column :email                     
    #column :current_sign_in_at
    #column :last_sign_in_at
    #column :sign_in_count
    bool_column :cash_admin
    bool_column :implementation_admin
    bool_column :plan_admin
    bool_column :super_admin
    default_actions
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Данные авторизации" do
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end
    f.inputs "Права доступа" do
      f.input :cash_admin
      f.input :implementation_admin
      f.input :plan_admin
      f.input :super_admin
    end
    f.actions                         
  end                                 
end                                   
