class ImplementationController < ApplicationController
  def index
    @implementations = Implementation.paginate(:page => params[:page], :per_page => 15)
  end
end
