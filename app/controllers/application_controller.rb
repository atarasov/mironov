class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      conference_path
    elsif resource_or_scope.is_a?(AdminUser)
      admin_admin_mains_path
      #raise resource_or_scope.inspect
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_admin_mains_path, :alert => exception.message
  end
end
