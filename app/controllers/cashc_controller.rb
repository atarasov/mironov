class CashcController < BaseController
  def index
    if params[:year]
      @cashc = Cashc.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",params[:year], Time.now.month, Time.now.day )
    else
      @cashc = Cashc.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",Time.now.year, Time.now.month, Time.now.day )
    end

    @p = Cashc.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end
  end
end
