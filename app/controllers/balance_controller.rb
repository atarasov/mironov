class BalanceController < ApplicationController
  def index
    @balance = Balance.all
  end
end
