# encoding: utf-8
class PlanController < ApplicationController

  def index
    if params[:year]
      @plans = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",params[:year], Time.now.month, Time.now.day )
    else
      @plans = Asrt.where("YEAR(DAT) = 2012 AND MONTH(DAT) = ? AND DAY(DAT) = ?", Time.now.month, Time.now.day )
    end


    @p = Asrt.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end

  end

  def show
    @month_plans_arr = []
    @days_plans_arr = []
    Time.now.year.to_i.downto (Time.now.year - 1).to_i  do |year|
      1.upto 12 do |month|
        @day = Time.new(year,month,1).end_of_month.day
        @month_plans_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
        @days_plans_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, Time.now.day).first

      end
    end

    @plan_arr =[]
    @itog =[]
    @fact_arr =[]
    @month_arr =[]
    @years_count_arr  =[]
    @days_plan_arr =[]
    @days_fact_arr =[]
    @days_month_arr =[]

    @month_plans_arr.each do |m|
      if m
        @plan_arr << m.PLM.to_f
        @fact_arr << m.VRS.to_f
        @month_arr << m.DAT.to_date.to_s+"  <br/>(<b>"+ Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_s+" тонн</b>)"
        @years_count_arr << Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_f
        #raise @years_count_arr.inspect
        @name = m.NAIM
        @itog << Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_f
      end
    end


    @days_plans_arr.each do |d|
      @days_plan_arr << d.PLS.to_f if d
      @days_fact_arr << d.VRS.to_f if d
      @days_month_arr << d.DAT.to_date.to_s + '(<b>'+d.PLM.to_f.to_s+'</b>)' if d
      #@name = d.NAIM
    end


    @bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = @month_arr
      f.series(:type=> 'bar', :name=>'План',:data=> @plan_arr)
      f.series(:type=> 'bar', :name=>'Факт',:data=> @fact_arr)
      #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:1200px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' тонн'})
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -100,
                 y: -10,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

    @line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:gridLineWidth] =  1
      f.series(:type=> 'spline', :name=>'План',:data=> @plan_arr)
      f.series(:type=> 'spline', :name=>'Факт',:data=> @fact_arr)
      f.title({ :text=>"Динамика выполнения плана по месяцам - <b>" +@name+"</b>"})
      f.exporting({ :enabled => true})
      f.html_options[:style] = " !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.plot_options({ :line=> {:dataLabels => { :enabled => true}}})
      f.xAxis({:labels => {:rotation => 0, :align => 'right'}, :categories => @month_arr })
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -100,
                 y: -10,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})

    end

    @days_bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = @days_month_arr
      f.series(:type=> 'bar', :name=>'План',:data=> @days_plan_arr)
      f.series(:type=> 'bar', :name=>'Факт',:data=> @days_fact_arr)
      #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:1200px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -100,
                 y: -10,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

    @days_line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.series(:type=> 'spline', :name=>'План',:data=> @days_plan_arr)
      f.series(:type=> 'spline', :name=>'Факт',:data=> @days_fact_arr)
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.title({ :text=>"Динамика выполнения плана по месяцам за "+Time.now.day.to_s+" рабочих дней - <b>" +@name+"</b>"})
      f.html_options[:style] = "width:96% !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs=> true })
      f.plot_options({ :line=> {:dataLabels => { :enabled => true}}})
      f.xAxis({:labels => {:rotation => 0, :align => 'right'}, :categories => @days_month_arr })
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -100,
                 y: -10,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

  end

  def all
    @month_plans_arr = []
    @days_plans_arr = []
    Time.now.year.to_i.downto 2008  do |year|
      1.upto 12 do |month|
        @day = Time.new(year,month,1).end_of_month.day
        @month_plans_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
        @days_plans_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, Time.now.day).first

      end
    end

    @plan_arr =[]
    @itog =[]
    @fact_arr =[]
    @month_arr =[]
    @years_count_arr  =[]
    @days_plan_arr =[]
    @days_fact_arr =[]
    @days_month_arr =[]

    @month_plans_arr.each do |m|
      if m
        @plan_arr << m.PLM.to_f
        @fact_arr << m.VRS.to_f
        @month_arr << m.DAT.to_date.to_s+"  <br/>(<b>"+ Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_s+" тонн</b>)"
        @years_count_arr << Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_f
        #raise @years_count_arr.inspect
        @name = m.NAIM
        @itog << Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_f
      end
    end


    @days_plans_arr.each do |d|
      @days_plan_arr << d.PLS.to_f if d
      @days_fact_arr << d.VRS.to_f if d
      @days_month_arr << d.DAT.to_date.to_s + '(<b>'+d.PLM.to_f.to_s+'</b>)' if d
      #@name = d.NAIM
    end


    @bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = @month_arr
      f.series(:type=> 'bar', :name=>'План',:data=> @plan_arr)
      f.series(:type=> 'bar', :name=>'Факт',:data=> @fact_arr)
      #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:3600px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' тонн'})
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -100,
                 y: -10,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

    @line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:gridLineWidth] =  1
      f.series(:type=> 'spline', :name=>'План',:data=> @plan_arr)
      f.series(:type=> 'spline', :name=>'Факт',:data=> @fact_arr)
      f.title({ :text=>"Динамика выполнения плана по месяцам - <b>" +@name+"</b>"})
      f.exporting({ :enabled => true})
      f.html_options[:style] = " !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.plot_options({ :line=> {:dataLabels => { :enabled => true}}})
      f.xAxis({:labels => {:rotation => -30, :align => 'right'}, :categories => @month_arr })
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -100,
                 y: -10,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})

    end

    @days_bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = @days_month_arr
      f.series(:type=> 'bar', :name=>'План',:data=> @days_plan_arr)
      f.series(:type=> 'bar', :name=>'Факт',:data=> @days_fact_arr)
      #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:3600px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -100,
                 y: -10,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

    @days_line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.series(:type=> 'spline', :name=>'План',:data=> @days_plan_arr)
      f.series(:type=> 'spline', :name=>'Факт',:data=> @days_fact_arr)
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.title({ :text=>"Динамика выполнения плана по месяцам за "+Time.now.day.to_s+" рабочих дней - <b>" +@name+"</b>"})
      f.html_options[:style] = "width:96% !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs=> true })
      f.plot_options({ :line=> {:dataLabels => { :enabled => true}}})
      f.xAxis({:labels => {:rotation => -30, :align => 'right'}, :categories => @days_month_arr })
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -100,
                 y: -10,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

  end


end
