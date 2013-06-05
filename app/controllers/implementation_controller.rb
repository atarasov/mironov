# encoding: utf-8
class ImplementationController < BaseController
  PER_PAGE = 20

  def index
    if params[:day]
      @dat = Time.now - (params[:day].to_i + 1).day
      @day = (Time.now - (params[:day].to_i + 1).day).day
    else
      @dat = (Time.now - 1.day)
      @day = (Time.now - 1.day).day
    end
    if params[:year]
      @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", params[:year], @dat.month, @day)
    else
      @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @day)
      while @implementations.size == 0 do
        @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @dat.day)
        @dat = @dat - 1.day
        @day = @day - 1
      end
    end

    @p = Implementation.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end

  end
  def prev_day

    @dat = params[:dat].to_date - 1.day

    if params[:year]
      @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", params[:year], @dat.month, @dat.day)
    else
      @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @dat.day)
      while @implementations.size == 0 do
        @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @dat.day)
        @dat = @dat - 1.day
      end
    end

    @p = Implementation.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end

    respond_to do |format|
      format.html #(render :action => :index)
      format.js   # show_rec_horses.js.erb
    end
  end

  def next_day

    @dat = params[:dat].to_date + 1.day

    if params[:year]
      @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", params[:year], @dat.month, @dat.day)
    else
      @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @dat.day)
      while @implementations.size == 0 do
        @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @dat.day)
        @dat = @dat - 1.day
      end
    end

    @p = Implementation.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end

    respond_to do |format|
      format.html #(render :action => :index)
      format.js   # show_rec_horses.js.erb
    end
  end

  def show
    year = Time.now.year - 2
    @plans = Implementation.where('N = ? AND YEAR(DAT) >= ?', params[:id], year).order("DAT DESC")

    @month_plans_arr = []
    @days_plans_arr = []
    Time.now.year.to_i.downto (Time.now.year - 1).to_i do |year|
      if year == Time.now.year
        months = Time.now.month
      else
        months = 12
      end
      months.downto 1 do |month|
        if year == Time.now.year && month == Time.now.month
          @day = (Time.now - 1.day).day
          @dat = (Time.now - 1.day)
          @nowday = @dat.day
          impl = Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @dat.day).first
          #raise impl.inspect
          while impl == nil do
            impl = Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], @dat.year, @dat.month, @dat.day).first
            @nowday = @dat.day
            @dat = @dat - 1.day
            @day = @day - 1
          end

          @month_plans_arr << impl.id if impl
        else
          @day = Time.new(year, month, 1).end_of_month.day
          @month_plans_arr << Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first.id if Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
        end


        #@month_plans << Implementation.where('N = ?', params[:id]).last.id
        @month_plans = Implementation.where('id IN (?)',@month_plans_arr).order("DAT DESC")
      end
    end
  end

  def show2

    @month_plans_arr = []
    @days_plans_arr = []
    Time.now.year.to_i.downto (Time.now.year - 1).to_i do |year|
      if year == Time.now.year
        months = Time.now.month
      else
        months = 12
      end
      months.downto 1 do |month|
        if year == Time.now.year && month == Time.now.month
          @day = (Time.now - 1.day).day
          @nowday = @day
          impl = Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
          #raise impl.inspect
          while impl == nil do
            impl = Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
            @nowday = @day
            @day = @day - 1
          end

          @month_plans_arr << impl
        else
          @day = Time.new(year, month, 1).end_of_month.day
          @month_plans_arr << Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
        end


        #@days_plans_arr << Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, Time.now.day).first
      end
    end

    @date_arr =[]
    @day_to_now_arr=[]

    @month_arr =[]
    @yearsumm = []

    @day_arr =[]
    @days_plan_arr =[]
    @days_fact_arr =[]
    @days_month_arr =[]
    #raise @month_plans_arr.inspect
    @month_plans_arr.each do |m|
      if m
        #@month_arr << m.SUMM.to_f if m
        @month_arr << Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND N = ?", m.DAT.to_date.year, m.DAT.to_date.month, params[:id]).sum("SUM").to_f if m
        s =Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = ?", m.DAT.to_date.year, m.DAT.to_date.month, @nowday , params[:id]).first if m
        @day_to_now_arr << s.SUMM.to_f if s
        #raise m.inspect
        @date_arr << Russian::strftime(s.DAT.to_date, "%d %B %Y").to_s if s#+"  <br/>(<b>"+ Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, Time.now.day, params[:id]).first.SUMY.to_s+" тонн</b>)"
        @name = s.NAIM if s
        @yearsumm << Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = ?", m.DAT.to_date.year, m.DAT.to_date.month, @nowday , params[:id]).first.SUMY.to_s + " т" if m
      end
    end
    #raise @month_arr.inspect

    #@days_plans_arr.each do |d|
    #  @days_plan_arr << d.PLM.to_f if d
    #  @days_fact_arr << d.VRS.to_f if d
    #  @days_month_arr << d.DAT.to_date if d
    #end

    #raise @name.inspect
    @bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.xAxis([{:labels => {:rotation => 0, :align => 'right'}, :categories => @date_arr},
               {:labels => {:rotation => 0, :align => 'left'}, :categories => @yearsumm, linkedTo: 0, opposite: true}])
      f.title({:text => "Динамика реализации - <b>" +@name +"</b>"})
      f.series(:type => 'bar',
               :name => 'Реализация за месяц', :data => @month_arr,
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
      f.series(:type => 'bar', :name => 'Реализация на сегодняшний день('+@nowday.to_s+' рабочих дней) ',
               :data => @day_to_now_arr,
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
      #f.plot_options({:bar => {:dataLabels => {:enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:1200px !important;"
      f.tooltip({:shared => true, :crosshairs => true, :valueSuffix => ' тонн'})
      f.legend({layout: 'vertical',
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
      f.options[:xAxis][:gridLineWidth] = 1
      f.series(:type => 'spline', :name => 'Реализация за месяц', :data => @month_arr.reverse)
      f.series(:type => 'spline', :name => 'Реализация на сегодняшний день('+@nowday.to_s+' рабочих дней) ', :data => @day_to_now_arr.reverse)
      f.title({:text => "Динамика реализации - <b>" +@name +"</b>"})
      f.exporting({:enabled => true})
      f.html_options[:style] = "width:96% !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs => true, :valueSuffix => ' т'})
      f.xAxis({:labels => {:rotation => 0, :align => 'right'}, :categories => @date_arr.reverse})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -150,
                y: 0,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true})

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

    #@days_line_graph = LazyHighCharts::HighChart.new('Area') do |f|
    #  f.series(:type=> 'area', :name=>'Реализация за'+Time.now.day.to_s+'рабочих дней',:data=>@day_to_now_arr)
    #  f.title({ :text=>"Динамика реализации за "+Time.now.day.to_s+" рабочих дней - <b>" +@name+"</b>"})
    #  f.html_options[:style] = "width:96% !important; height:800px !important;"
    #  f.tooltip({:shared => true, :crosshairs=> true })
    #  f.xAxis({:labels => {:rotation => 0, :align => 'right'}, :categories => @date_arr })
    #  f.legend({ layout: 'vertical',
    #             align: 'right',
    #             verticalAlign: 'top',
    #             x: -100,
    #             y: -10,
    #             floating: true,
    #             borderWidth: 1,
    #             backgroundColor: '#FFFFFF',
    #             shadow: true})
    #end

    @day_sbar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.xAxis([{:labels => {:rotation => 0, :align => 'right'}, :categories => @date_arr},
               {:labels => {:rotation => 0, :align => 'left'}, :categories => @yearsumm, linkedTo: 0, opposite: true}])
      f.title({:text => "Динамика реализации - <b>" +@name +"</b>"})
      f.series(:type => 'bar', :name => 'Реализация на сегодняшний день('+@nowday.to_s+' рабочих дней) ', :data => @day_to_now_arr,
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
      f.plot_options({:bar => {:dataLabels => {:enabled => true}}})
      f.html_options[:style] = "width:95% !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs => true, :valueSuffix => ' тонн'})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -150,
                y: 0,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true})
    end

  end

  def all
    @month_plans_arr = []
    @days_plans_arr = []
    2008.up_to Time.now.year.to_i do |year|
      1.upto 12 do |month|
        @day = Time.new(year, month, 1).end_of_month.day
        @month_plans_arr << Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, @day).first
        #@days_plans_arr << Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', params[:id], year, month, Time.now.day).first
      end
    end

    @date_arr =[]
    @day_to_now_arr=[]

    @month_arr =[]
    @yearsumm = []
    @day_arr =[]
    @days_plan_arr =[]
    @days_fact_arr =[]
    @days_month_arr =[]

    @month_plans_arr.each do |m|
      if m
        @month_arr << m.SUMM.to_f if m
        s =Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = ?", m.DAT.to_date.year, m.DAT.to_date.month, (Time.now - 1.day).day, params[:id]).first if m
        @day_to_now_arr << s.SUMM.to_f if m
        @date_arr << Russian::strftime(s.DAT.to_date, "%d %B %Y") if m #.to_s+"  <br/>(<b>"+ Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = ?",m.DAT.to_date.year, m.DAT.to_date.month, Time.now.day, params[:id]).first.SUMY.to_s+" тонн</b>)"
        @yearsumm << Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = ?", m.DAT.to_date.year, m.DAT.to_date.month, (Time.now - 1.day).day, params[:id]).first.SUMY.to_s+" т" if m
        @name = s.NAIM if m
      end
    end


    #@days_plans_arr.each do |d|
    #  @days_plan_arr << d.PLM.to_f if d
    #  @days_fact_arr << d.VRS.to_f if d
    #  @days_month_arr << d.DAT.to_date if d
    #end


    @bar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.xAxis([{:labels => {:rotation => 0, :align => 'right'}, :categories => @date_arr},
               {:labels => {:rotation => 0, :align => 'left'}, :categories => @yearsumm, linkedTo: 0, opposite: true}])
      f.title({:text => "Динамика реализации - <b>" +@name +"</b>"})
      f.series(:type => 'bar', :name => 'Реализация за месяц', :data => @month_arr,
               :groupPadding => '0.9',
               :dataLabels => {
                   :enabled => true,
                   :rotation => 0,
                   :color => '#FFFFFF',
                   :align => 'right',
                   :x => -20,
                   :y => 3,
               })
      f.series(:type => 'bar', :name => 'Реализация на сегодняшний день('+Time.now.day.to_s+' рабочих дней) ', :data => @day_to_now_arr,
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
      f.plot_options({:bar => {:dataLabels => {:enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:3600px !important;"
      f.tooltip({:shared => true, :crosshairs => true, :valueSuffix => ' тонн'})
      f.legend({layout: 'vertical',
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
      f.options[:xAxis][:gridLineWidth] = 1
      f.series(:type => 'spline', :name => 'Реализация за месяц', :data => @month_arr)
      f.series(:type => 'spline', :name => 'Реализация на сегодняшний день('+(Time.now - 1.day).day.to_s+' рабочих дней) ', :data => @day_to_now_arr)
      f.title({:text => "Динамика реализации - <b>" +@name +"</b>"})
      f.exporting({:enabled => true})
      f.html_options[:style] = "width:96% !important; height:800px !important;"
      f.tooltip({:shared => true, :crosshairs => true, :valueSuffix => ' т'})
      f.xAxis({:labels => {:rotation => -30, :align => 'right'}, :categories => @date_arr})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -100,
                y: -10,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true})

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

    #@days_line_graph = LazyHighCharts::HighChart.new('Area') do |f|
    #  f.series(:type=> 'area', :name=>'Реализация за'+Time.now.day.to_s+'рабочих дней',:data=>@day_to_now_arr)
    #  f.title({ :text=>"Динамика реализации за "+Time.now.day.to_s+" рабочих дней - <b>" +@name+"</b>"})
    #  f.html_options[:style] = "width:96% !important; height:800px !important;"
    #  f.tooltip({:shared => true, :crosshairs=> true })
    #  f.xAxis({:labels => {:rotation => -30, :align => 'right'}, :categories => @date_arr })
    #  f.legend({ layout: 'vertical',
    #             align: 'right',
    #             verticalAlign: 'top',
    #             x: -100,
    #             y: -10,
    #             floating: true,
    #             borderWidth: 1,
    #             backgroundColor: '#FFFFFF',
    #             shadow: true})
    #end

    @day_sbar_graph = LazyHighCharts::HighChart.new('Area') do |f|
      f.xAxis([{:labels => {:rotation => 0, :align => 'right'}, :categories => @date_arr},
               {:labels => {:rotation => 0, :align => 'left'}, :categories => @yearsumm, linkedTo: 0, opposite: true}])
      f.title({:text => "Динамика реализации - <b>" +@name +"</b>"})
      f.series(:type => 'bar', :name => 'Реализация на сегодняшний день('+(Time.now - 1.day).day.to_s+' рабочих дней) ', :data => @day_to_now_arr)
      #f.plotOptions[{:bar => {  :dataLabels => { :enabled => true} }}],
      f.plot_options({:bar => {:dataLabels => {:enabled => true}}})
      f.html_options[:style] = "width:100% !important; height:1200px !important;"
      f.tooltip({:shared => true, :crosshairs => true, :valueSuffix => ' тонн'})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -150,
                y: 0,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true})
    end

  end

end
