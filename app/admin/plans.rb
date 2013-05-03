# encoding: utf-8
ActiveAdmin.register Plan , {:sort_order => "assortment.old_id ASC"} do
  scope :today, :default => true do |plan|
    plan.where("MONTH(date) = ? AND YEAR(date) = ?", Time.now.month, Time.now.year)
  end
  index do


    selectable_column
    #column(:assortment) { |i| best_in_place i, :assortment, :type => :select, :collection => Assortment.all.map {|a| [a.id, a.name]}, :path => [:admin, i] }
    #column(:date) { |i| best_in_place i, :date, :type => :input, :path => [:admin, i] }
    #column(:day) { |i| best_in_place i, :day, :type => :date, :path => [:admin, i] }
    #column(:month) { |i| best_in_place i, :month, :type => :input, :path => [:admin, i] }
    column :assortment do |plan|
      if plan.assortment.level == 2
        @class ='w5'
      elsif plan.assortment.level == 3
        @class ='w10'
      else
        @class ='w0'
      end
      div :class => @class do
        plan.assortment.name
      end
    end
    column :date  do |plan|
      Russian::strftime(plan.date, "%B %Y")
    end
    column :day do |plan|
      number_to_currency plan.day, :separator => ".", :delimiter => " ", :precision => 3, :unit => ""
    end
    #column :month
    column(:month) { |i| best_in_place i,
                                       :month,
                                       :type => :input,
                                       :path => [:admin, i],
                                       :display_with => :number_to_currency,
                                       :helper_options => {:separator => ".",
                                                           :delimiter => " ",
                                                           :precision => 3,
                                                           :unit => ""} }

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
