class ImplementationController < ApplicationController
  PER_PAGE = 20
  def index
    if params[:year]
      @implementations = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?",params[:year], Time.now.month, Time.now.day )
    else
      @implementations = Implementation.where("YEAR(DAT) = 2012 AND MONTH(DAT) = ? AND DAY(DAT) = ?", Time.now.month, Time.now.day )
    end

    @p = Implementation.select("DISTINCT YEAR(DAT) AS YEARS")

    @m =[]

    @p.each do |o|
      @m << o[:YEARS].to_i
    end

  end
end
