class CashController < ApplicationController
  def index
    if params[:year]
      @cash = Cash.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",params[:year], Time.now.month, Time.now.day )
    else
      @cash = Cash.where("YEAR(DAT) = 2012 AND MONTH(DAT) = ? AND DAY(DAT) = ?", Time.now.month, Time.now.day )
    end

    @p = Cash.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end
  end
end
