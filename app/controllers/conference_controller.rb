# encoding: utf-8
class ConferenceController < BaseController
  def index

    @plan = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ?  AND DN = ? AND N = 1",Time.now.year,Time.now.month, (Time.now - 1.day).day).first
    #raise @plan.inspect
    if @plan.blank? || @plan == nil
      @plan = Asrt.where(" PLM IS NOT NULL AND PLD IS NOT NULL AND N = 1" ).last(1).first
      #raise @plan.inspect
    end
    @bar = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = []
      f.series(:type=> 'bar', :name=>'План нарастающий',:data=> [@plan.PLD.to_i])
      f.series(:type=> 'bar', :name=>'План на месяц',:data=> [@plan.PLM.to_i])
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.legend({ layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -100,
                 y: -10,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true})


      f.yAxis({ :min=> 0, :title=> {:text => "Тонны", :align =>'high'}})
      f.tooltip({:shared => true,:valueSuffix => ' тонн'})
      f.html_options[:style] = "width:95% !important; height:200px !important;"
    end

    @bar2 = LazyHighCharts::HighChart.new('Area1') do |f|
      f.options[:xAxis][:categories] = []
      f.series(:type=> 'bar', :name=>'Реализация дневная',:data=> [@plan.RLD.to_i])
      f.series(:type=> 'bar', :name=>'Остаток дневной',:data=> [@plan.OST.to_i])
      f.series(:type=> 'bar', :name=>'Выработка дневная',:data=> [@plan.VRD.to_i])
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.yAxis({ :min=> 0, :title=> {:text => "Тонны", :align =>'high'}})
      f.tooltip({:shared => true,:valueSuffix => ' тонн'})
      f.html_options[:style] = "width:95% !important; height:200px !important;"
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

  def show
    @plan = Asrt.where("YEAR(DAT) = ? AND MONTH(DAT) = ?  AND DN = ? AND N = ?",Time.now.year,Time.now.month, (Time.now - 1.day).day, params[:id]).first
    if @plan.blank? || @plan == nil
      @plan = Asrt.where(" PLM IS NOT NULL AND PLD IS NOT NULL AND N = ?", params[:id]).last(1).first
      #raise @plan.inspect
    end
    @bar = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = []
      f.series(:type=> 'bar', :name=>'План нарастающий',:data=> [@plan.PLD.to_i])
      f.series(:type=> 'bar', :name=>'План на месяц',:data=> [@plan.PLM.to_i])
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.yAxis({ :min=> 0, :title=> {:text => "Тонны", :align =>'high'}, :labels =>  { :overflow => 'justify'}})
      f.tooltip({:shared => true,:valueSuffix => ' тонн'})
      f.html_options[:style] = "width:95% !important; height:200px !important;"
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

    @bar2 = LazyHighCharts::HighChart.new('Area1') do |f|
      f.options[:xAxis][:categories] = []
      f.series(:type=> 'bar', :name=>'Реализация дневная',:data=> [@plan.RLD.to_i])
      f.series(:type=> 'bar', :name=>'Остаток дневной',:data=> [@plan.OST.to_i])
      f.series(:type=> 'bar', :name=>'Выработка дневная',:data=> [@plan.VRD.to_i])
      f.plot_options({ :bar=> {:dataLabels => { :enabled => true}}})
      f.yAxis({ :min=> 0, :title=> {:text => "Тонны", :align =>'high'}})
      f.tooltip({:shared => true,:valueSuffix => ' тонн'})
      f.html_options[:style] = "width:95% !important; height:200px !important;"
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
