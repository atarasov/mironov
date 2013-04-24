# encoding: utf-8
ActiveAdmin.register Plan do
  index do
    column :assortment
    column :date
    column :day
    column :month

    default_actions
  end





  filter :assortment
  filter :date


  form do |f|
    f.inputs "План на месяц/день" do
      f.input :assortment, :as => :select
      f.input :date, :as => :datepicker, :input_html => { :value => Time.now.end_of_month.to_date }
      f.input :day
      f.input :month
    end
    f.actions

  end
end
