# encoding: utf-8
class PlanController < ApplicationController

  def index
    if params[:year]
      @plans = Asrt.paginate(:page => params[:page], :per_page => 20).where("YEAR(DAT) = ?",params[:year])
    else
      @plans = Asrt.paginate(:page => params[:page], :per_page => 20)
    end


    @p = Asrt.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end

  end

  def show

    @m = []
    @s = []
    @d = []
    @d2 = []
    @d3 = []
    @y = []
    s = "2010-"+Time.now.strftime('%m-%d 00:00:00')
    d = "2009-"+Time.now.strftime('%m-%d 00:00:00')

    @months = Asrt.where('N = ? AND DN = ? AND MONTH(DAT) = ?', params[:id], Time.now.day, Time.now.strftime('%m'))
    @months2 = Asrt.where('N = ? AND DN = ? AND MONTH(DAT) = ?', params[:id], Time.now.day - 1, Time.now.strftime('%m'))
    @months3 = Asrt.where('N = ? AND DN = ? AND MONTH(DAT) = ?', params[:id], Time.now.day - 2 , Time.now.strftime('%m'))
    @cur_month = Asrt.where('N = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?', params[:id], Time.now.strftime('%m'), Time.now.strftime('%Y').to_i - 1)
    #@plan = Asrt.where(:N => params[:id], :DAT => s.to_s).first
    #@old_plan = Asrt.where(:N => params[:id], :DAT => d.to_s).first
    @months.each do |o|
      @m << o[:PLM].to_f
      @s << o[:PLS].to_f
      @d << o[:PLD].to_f
      @y << o[:DAT].strftime('%Y')

    end
    @cur_d =[]
    @cur_day =[]
    @cur_month.each do |o|
      @cur_d << o[:PLD].to_f
      @cur_day << o[:DAT].strftime('%d')

    end

    @months2.each do |o|
      @d2 << o[:PLD].to_f

    end

    @months3.each do |o|
      @d3 << o[:PLD].to_f

    end
    @bar = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = @y
      f.series(:type=> 'spline', :name=>'План',:data=> @m)
      f.title({ :text=>"График изменения плана относительно месяцов прошлых лет"})
      f.html_options[:style] = "width:1200px !important; height:400px !important;"
    end

    @bar2 = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = @y
      f.series(:type=> 'spline', :name=>'План',:data=> @m)
      f.series(:type=> 'spline', :name=>'Выполняемость плана',:data=> @s)
      f.title({ :text=>"График изменения выполненности плана относительно месяцов прошлых лет"})
      f.html_options[:style] = "width:1200px !important; height:400px !important;"
    end

    @bar3 = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = @y
      f.series(:type=> 'spline', :name=>'Сделанно позавчера',:data=> @d3)
      f.series(:type=> 'spline', :name=>'Сделанно вчера',:data=> @d2)
      f.series(:type=> 'spline', :name=>'Сделанно сегодня',:data=> @d)
      f.title({ :text=>"График изменения выполненности плана на текущий день относительно прошлых лет"})
      f.html_options[:style] = "width:1200px !important; height:400px !important;"

    end


    @bar4 = LazyHighCharts::HighChart.new('Area') do |f|
      f.options[:xAxis][:categories] = @cur_day
      f.series(:type=> 'spline', :name=>'Сделанно',:data=> @cur_d)
      f.title({ :text=>"График выполняемости плана на текущий месяц"})
      f.html_options[:style] = "width:1200px !important; height:400px !important;"

    end
  end


end
