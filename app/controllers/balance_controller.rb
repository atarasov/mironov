class BalanceController < BaseController
  def index
    @balance = Balance.all
  end
end
