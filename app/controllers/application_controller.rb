#include BestInPlace::BestInPlaceHelpers
class ApplicationController < ActionController::Base
  include BestInPlace
  before_filter :plan_create, :only => :index
  before_filter :implementation_create, :only => :index
  protect_from_forgery

  def plan_create
    @asrt = Asrt.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", Time.now.day, Time.now.month, Time.now.year)
    if @asrt && @asrt.size == 0
      Assortment.all.each do |assortment|
        Asrt.create({:NAIM => assortment.name, :N => assortment.id, :DAT => Time.now})
      end
    end
  end
  def implementation_create
    @impl = Implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", Time.now.day, Time.now.month, Time.now.year)
    if @impl && @impl.size == 0
      Direction.all.each do |assortment|
        Implementation.create({:NAIM => assortment.name, :N => assortment.id, :DAT => Time.now})
      end
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      conference_path
    elsif resource_or_scope.is_a?(AdminUser)
      admin_assortments_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_assortments_path, :alert => exception.message
  end
end
