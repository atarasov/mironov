# encoding: utf-8
ActiveAdmin.register Plan do
  index do
    #column(:assortment) { |i| best_in_place i, :assortment, :type => :select, :collection => Assortment.all.map {|a| [a.id, a.name]}, :path => [:admin, i] }
    #column(:date) { |i| best_in_place i, :date, :type => :input, :path => [:admin, i] }
    #column(:day) { |i| best_in_place i, :day, :type => :date, :path => [:admin, i] }
    #column(:month) { |i| best_in_place i, :month, :type => :input, :path => [:admin, i] }
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
