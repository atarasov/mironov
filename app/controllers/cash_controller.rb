class CashController < ApplicationController
  def index
    @cash = Cash.paginate(:page => params[:page], :per_page => 15)
  end
end
