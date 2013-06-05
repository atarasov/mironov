class CashController < BaseController
  def index
    @dat = Time.now  - 1.day
    if params[:year]
      @cash = Cash.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",params[:year], Time.now.month, (Time.now - 1.day).day )
    else
      @cash = Cash.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", Time.now.year, Time.now.month, (Time.now - 1.day).day )
    end

    @p = Cash.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end
  end

  def prev_day

    @dat = params[:dat].to_date - 1.day

    @cash = Cash.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @dat.day )

    @p = Cash.select("DISTINCT YEAR(DAT) AS YEARS")

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

    @dat = params[:dat].to_date - 1.day

    @cash = Cash.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @dat.day )

    @p = Cash.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end

    respond_to do |format|
      format.html #(render :action => :index)
      format.js   # show_rec_horses.js.erb
    end
  end
end
