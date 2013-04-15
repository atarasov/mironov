# encoding: utf-8
class ImplementationController < ApplicationController
  PER_PAGE = 20
  def index
    if params[:year]
      @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",params[:year], Time.now.month, Time.now.day )
    else
      @implementations = Implementation.where("YEAR(DAT) = 2012 AND MONTH(DAT) = ? AND DAY(DAT) = ?", Time.now.month, Time.now.day )
    end

    @p = Implementation.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end

  end

  def show

    @month_plans_arr = []
    @days_plans_arr = []
    2008.upto Time.now.year.to_i do |year|
      1.upto 12 do |month|
        @day = Time.new(year,month,1).end_of_month.day
        @month_plans_arr << Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
        #@days_plans_arr << Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, Time.now.day).first
      end
    end

    @date_arr =[]
    @day_to_now_arr=[]

    @month_arr =[]

    @day_arr  =[]
    @days_plan_arr =[]
    @days_fact_arr =[]
    @days_month_arr =[]

    @month_plans_arr.each do |m|
      if m
        @month_arr << m.SUMM.to_f
        s =Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, Time.now.day, params[:id]).first
        @day_to_now_arr << s.SUMM.to_f
        @date_arr << s.DAT.to_date.to_s
        #raise @years_count_arr.inspect
      end
    end


    #@days_plans_arr.each do |d|
    #  @days_plan_arr << d.PLM.to_f if d
    #  @days_fact_arr << d.VRS.to_f if d
    #  @days_month_arr << d.DAT.to_date if d
    #end


    #@bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
    #  f.options[:xAxis][:categories] = @month_arr
    #  f.labels(:items=>[:html=>"Динамика выполнения плана по месяцам", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
    #  f.series(:type=> 'bar', :name=>'План',:data=> @plan_arr)
    #  f.series(:type=> 'bar', :name=>'Факт',:data=> @fact_arr)
    #  #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
    #  f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
    #  f.html_options[:style] = "width:100% !important; height:3400px !important;"
    #end

    @line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:gridLineWidth] =  1
      f.series(:type=> 'spline', :name=>'Реализация за месяц',:data=> @month_arr )
      f.series(:type=> 'spline', :name=>'Реализация на сегодняшний день(нарастающая)',:data=> @day_to_now_arr)
      f.title({ :text=>"Динамика реализации"})
      f.exporting({ :enabled => true})
      f.html_options[:style] = "width:96% !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.xAxis({:labels => {:rotation => -90, :align => 'right'}, :categories => @date_arr })

    end

    #@days_bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
    #  f.options[:xAxis][:categories] = @days_month_arr
    #  f.labels(:items=>[:html=>"Динамика выполнения плана по месяцам за "+Time.now.day.to_s+" рабочих дней", :style=>{:left=>"40px", :top=>"10px", :color=>"black"} ])
    #  f.series(:type=> 'bar', :name=>'План',:data=> @days_plan_arr)
    #  f.series(:type=> 'bar', :name=>'Факт',:data=> @days_fact_arr)
    #  #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
    #  f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
    #  f.html_options[:style] = "width:100% !important; height:3400px !important;"
    #end

    @days_line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.series(:type=> 'area', :name=>'План',:data=>@day_to_now_arr)
      f.title({ :text=>"Динамика реализации за "+Time.now.day.to_s+" рабочих дней"})
      f.html_options[:style] = "width:96% !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs=> true })
      f.xAxis({:labels => {:rotation => -90, :align => 'right'}, :categories => @date_arr })
    end

  end

end
