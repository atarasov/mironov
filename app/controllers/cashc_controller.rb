class CashcController < BaseController
  def index
    @dat = Time.now  - 1.day
    if params[:day]
      @dat = Time.now - (params[:day].to_i + 1).day
    else
      @dat = Time.now - 1.day
    end
    if params[:year]

      @cashc = Cashc.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",params[:year], @dat.month, @dat.day )
    else
      @cashc = Cashc.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",@dat.year, @dat.month, @dat.day )
      while @cashc.size == 0 do
        @cashc = Cashc.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",@dat.year, @dat.month, @dat.day )
        @dat = @dat - 1.day
      end
    end

    @p = Cashc.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end
  end

  def prev_day

    @dat = params[:dat].to_date - 1.day

    @cashc = Cashc.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @dat.day )

    @p = Cashc.select("DISTINCT YEAR(DAT) AS YEARS")

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

    @cashc = Cashc.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?", @dat.year, @dat.month, @dat.day )

    @p = Cashc.select("DISTINCT YEAR(DAT) AS YEARS")

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
