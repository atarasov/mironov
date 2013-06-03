class CashController < BaseController
  def index
    if params[:day]
      @dat = Time.now - (params[:day].to_i + 1).day
    else
      @dat = Time.now - 1.day
    end
    if params[:year]

      @cash = Cash.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",params[:year], @dat.month, @dat.day )
    else
      @cash = Cash.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",@dat.year, @dat.month, @dat.day )
      while @cash.size == 0 do
        @cash = Cash.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",@dat.year, @dat.month, @dat.day )
        @dat = @dat - 1.day
      end
    end

    @p = Cash.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end
  end
end
