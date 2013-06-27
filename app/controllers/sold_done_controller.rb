class SoldDoneController < ApplicationController
  def index
    #implementation

    year = Time.now.year - 2
    @implementations = Implementation.where('N = ? AND YEAR(DAT) >= ?', 9, year).order("DAT DESC")

    @month_implementations_arr = []
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
          impl = Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', 9, year, month, @dat.day).first
          #raise impl.inspect
          while impl == nil do
            impl = Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', 9, @dat.year, @dat.month, @dat.day).first
            @nowday = @dat.day
            @dat = @dat - 1.day
            @day = @day - 1
          end

          @month_implementations_arr << impl.id if impl
        else
          @day = Time.new(year, month, 1).end_of_month.day
          @month_implementations_arr << Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', 9, year, month, @day).first.id if Implementation.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', 9, year, month, @day).first
        end

        @month_implementations = Implementation.where('id IN (?)',@month_implementations_arr).order("DAT DESC")
      end
    end

    #plan

    year = Time.now.year - 1
    @plans = Asrt.where('N = ? AND YEAR(DAT) >= ?', 1, year).order("DAT DESC")
    @month_plans = []
    @days_plans_arr = []
    @planday = (Time.now - 1.day)
    @nowday = @planday
    pl = Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', 1, @planday.year, @planday.month, @planday.day).first
    while pl == nil do
      @planday = @planday -1.day
      pl = Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', 1, @planday.year, @planday.month, @planday.day).first
      @nowday = @planday

    end
    Time.now.year.to_i.downto (Time.now.year - 1).to_i do |year|
      if year == Time.now.year
        months = Time.now.month
      else
        months = 12
      end
      months.downto 1  do |month|
        @day = Time.new(year,month,1).end_of_month.day
        @month_plans << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', 1, year, month, @day).first.id if Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', 1, year, month, @day).first
        @days_plans_arr << Asrt.where('N = ? AND YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ?', 1, year, month, @nowday.day).first

      end
    end
    @month_plans << Asrt.where('N = ?', 1).last.id
    @month_plans = Asrt.where('id IN (?)', @month_plans).order("DAT DESC")

  end
end
