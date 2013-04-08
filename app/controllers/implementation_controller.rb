class ImplementationController < ApplicationController
  PER_PAGE = 20
  def index
    @implementations = Implementation.paginate(:page => params[:page], :per_page => 20)
  end
end
