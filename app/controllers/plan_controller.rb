# encoding: utf-8
class PlanController < BaseController

  def index
    if params[:day]
      @day = (Time.now - (params[:day].to_i + 1).day).day
    else
      @day = (Time.now - 1.day).day
    end
    if params[:year]
      @plans = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",params[:year], Time.now.month, @day )
    else
      @plans = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",Time.now.year, Time.now.month, @day)
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
    (Time.now.year - 1).to_i.upto Time.now.year.to_i do |year|
      if year == Time.now.year
        months = Time.now.month
      else
        months = 12
      end
      1.upto months do |month|
        @day = Time.new(year,month,1).end_of_month.day
        @month_plans_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
        @days_plans_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, (Time.now - 1.day).day).first

      end
    end

    @plan_arr =[]
    @itog =[]
    @day_itog =[]
    @fact_arr =[]
    @month_arr =[]
    @years_count_arr  =[]
    @days_plan_arr =[]
    @days_fact_arr =[]
    @days_month_arr =[]

    @month_plans_arr.each do |m|
      if m
        @plan_arr << m.PLM.to_f if m
        @fact_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], m.DAT.to_date.year, m.DAT.to_date.month, (Time.now - 1.day).day).first.VRS.to_f if m
        @month_arr << Russian::strftime(m.DAT.to_date, "%d %B %Y") if m#.to_s+"  <br/>(<b>"+ Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_s+" тонн</b>)"
        @years_count_arr << Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_f if m
        #raise @years_count_arr.inspect
        @name = m.NAIM if m
        @itog << Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_s+" т" if m
      end
    end


    @days_plans_arr.each do |d|
      @days_plan_arr << d.PLS.to_f if d
      @days_fact_arr << d.VRS.to_f if d
      @days_month_arr << Russian::strftime(d.DAT.to_date, "%d %B %y") if d#.to_s + '<br/>(<b>'+d.PLM.to_f.to_s+'</b>) тонн' if d
      @day_itog << d.PLM.to_f.to_s+' т' if d
    end


    @bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.xAxis([{:labels => {:rotation => 0, :align => 'right'}, :categories => @month_arr,
                :pointWidth => '25',
                :groupPadding => '0.9',
                :dataLabels => {
                    :enabled => true,
                    :rotation => 0,
                    :color => '#FFFFFF',
                    :align => 'right',
                    :x => -20,
                    :y => 3,
                }},
               {:labels => {:rotation => 0, :align => 'left'}, :categories => @itog, linkedTo: 0, opposite: true}])
      #f.options[:xAxis][:categories] = @month_arr
      f.series(:type=> 'bar', :name=>'План на месяц',:data=> @plan_arr,
               :pointWidth => '25',
               :groupPadding => '0.9',
               :dataLabels => {
                   :enabled => true,
                   :rotation => 0,
                   :color => '#FFFFFF',
                   :align => 'right',
                   :x => -20,
                   :y => 3,
               })
      f.series(:type=> 'bar', :name=>'Факт нарастающий',:data=> @fact_arr,
               :pointWidth => '25',
               :groupPadding => '0.9',
               :dataLabels => {
                   :enabled => true,
                   :rotation => 0,
                   :color => '#FFFFFF',
                   :align => 'right',
                   :x => -20,
                   :y => 3,
               })
      #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
      #f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:1200px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -150,
                 y: 0,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

    @line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:gridLineWidth] =  2
      f.series(:type=> 'spline', :name=>'План на месяц',:data=> @plan_arr)
      f.series(:type=> 'spline', :name=>'Факт нарастающий',:data=> @fact_arr)
      f.title({ :text=>"Динамика выполнения плана по месяцам - <b>" +@name+"</b>"})
      f.exporting({ :enabled => true})
      f.html_options[:style] = " !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.plot_options({ :line=> {:dataLabels => { :enabled => true}}})
      f.xAxis({:labels => {:rotation => 0, :align => 'right'}, :categories => @month_arr })
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -150,
                 y: 0,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})

    end

    @days_bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.xAxis([{:labels => {:rotation => 0, :align => 'right'}, :categories => @days_month_arr},
               {:labels => {:rotation => 0, :align => 'left'}, :categories => @day_itog, linkedTo: 0, opposite: true}])
      f.series(:type=> 'bar', :name=>'План нарастающий',:data=> @days_plan_arr,
               :pointWidth => '25',
               :groupPadding => '0.9',
               :dataLabels => {
                   :enabled => true,
                   :rotation => 0,
                   :color => '#FFFFFF',
                   :align => 'right',
                   :x => -20,
                   :y => 3,
               })
      f.series(:type=> 'bar', :name=>'Факт нарастающий',:data=> @days_fact_arr,
               :pointWidth => '25',
               :groupPadding => '0.9',
               :dataLabels => {
                   :enabled => true,
                   :rotation => 0,
                   :color => '#FFFFFF',
                   :align => 'right',
                   :x => -20,
                   :y => 3,
               })
      #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
      #f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.html_options[:style] = "width:95% !important; height:1200px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -150,
                 y: 0,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

    @days_line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.series(:type=> 'spline', :name=>'План нарастающий',:data=> @days_plan_arr)
      f.series(:type=> 'spline', :name=>'Факт нарастающий',:data=> @days_fact_arr)
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.title({ :text=>"Динамика выполнения плана по месяцам за "+(Time.now - 1.day).day.to_s+" рабочих дней - <b>" +@name+"</b>"})
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
    2008.up_to Time.now.year.to_i  do |year|
      1.upto 12 do |month|
        @day = Time.new(year,month,1).end_of_month.day
        @month_plans_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
        @days_plans_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, (Time.now - 1.day).day).first

      end
    end

    @plan_arr =[]
    @itog =[]
    @day_itog =[]
    @fact_arr =[]
    @month_arr =[]
    @years_count_arr  =[]
    @days_plan_arr =[]
    @days_fact_arr =[]
    @days_month_arr =[]

    @month_plans_arr.each do |m|
      if m
        @plan_arr << m.PLM.to_f if m
        @fact_arr << m.VRS.to_f if m
        @month_arr << Russian::strftime(m.DAT.to_date, "%d %B %Y") if m # .to_s+"  <br/>(<b>"+ Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_s+" тонн</b>)"
        @years_count_arr << Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_f if m
        #raise @years_count_arr.inspect
        @name = m.NAIM
        @itog << Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) <= ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("VRD").to_s+" т" if m
      end
    end


    @days_plans_arr.each do |d|
      @days_plan_arr << d.PLS.to_f if d
      @days_fact_arr << d.VRS.to_f if d
      @days_month_arr << Russian::strftime(d.DAT.to_date, "%d %B %Y").to_s if d# + '(<b>'+d.PLM.to_f.to_s+'</b>)' if d
      @day_itog << d.PLM.to_f.to_s+' тонн' if d
    end


    @bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.xAxis([{:labels => {:rotation => 0, :align => 'right'}, :categories => @month_arr},
               {:labels => {:rotation => 0, :align => 'left'}, :categories => @itog, linkedTo: 0, opposite: true}])
      f.series(:type=> 'bar', :name=>'План на месяц',:data=> @plan_arr)
      f.series(:type=> 'bar', :name=>'Факт нарастающий',:data=> @fact_arr)
      #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:3600px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' тонн'})
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -150,
                 y: 0,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

    @line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:gridLineWidth] =  1
      f.series(:type=> 'spline', :name=>'План на месяц',:data=> @plan_arr)
      f.series(:type=> 'spline', :name=>'Факт нарастающий',:data=> @fact_arr)
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
      f.xAxis([{:labels => {:rotation => 0, :align => 'right'}, :categories => @days_month_arr},
               {:labels => {:rotation => 0, :align => 'left'}, :categories => @day_itog, linkedTo: 0, opposite: true}])
      f.series(:type=> 'bar', :name=>'План нарастающий',:data=> @days_plan_arr)
      f.series(:type=> 'bar', :name=>'Факт нарастающий',:data=> @days_fact_arr)
      #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:3600px !important;"
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -150,
                 y: -0,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})
    end

    @days_line_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.series(:type=> 'spline', :name=>'План нарастающий',:data=> @days_plan_arr)
      f.series(:type=> 'spline', :name=>'Факт нарастающий',:data=> @days_fact_arr)
      f.tooltip({:shared => true, :crosshairs=> true,:valueSuffix => ' т'})
      f.title({ :text=>"Динамика выполнения плана по месяцам за "+(Time.now - 1.day).day.to_s+" рабочих дней - <b>" +@name+"</b>"})
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
