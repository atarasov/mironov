class CashcController < ApplicationController
  def index
    @cashc = Cashc.paginate(:page => params[:page], :per_page => 15)
  end
end
