# encoding: utf-8
ActiveAdmin.register Plan do
  #scope :today, :default => true do |plan|
  #  plan.where("MONTH(date) = ? AND YEAR(date) = ?", Time.now.month, Time.now.year).order("old_id DESC")
  #end
  index do
    selectable_column
    #column(:assortment) { |i| best_in_place i, :assortment, :type => :select, :collection => Assortment.all.map {|a| [a.id, a.name]}, :path => [:admin, i] }
    #column(:date) { |i| best_in_place i, :date, :type => :input, :path => [:admin, i] }
    #column(:day) { |i| best_in_place i, :day, :type => :date, :path => [:admin, i] }
    #column(:month) { |i| best_in_place i, :month, :type => :input, :path => [:admin, i] }
    column :assortment
    column :date
    column :day
    #column :month
    column(:month) { |i| best_in_place i, :month, :type => :input, :path => [:admin, i] }

    default_actions
  end






  filter :assortment
  filter :date


  form do |f|
    f.inputs "План на месяц/день" do
      f.input :assortment, :as => :select
      f.input :date, :as => :datepicker, :input_html => { :value => Time.now.end_of_month.to_date }
      #f.input :day
      f.input :month
    end
    f.actions

  end
  before_save do |plan|
    plan.day = params[:plan][:month].to_f/Time.now.end_of_month.to_date.day
  end
end
