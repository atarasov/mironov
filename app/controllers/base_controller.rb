class BaseController < ApplicationController
  before_filter :authenticate_user!#, :exept => :admin
end