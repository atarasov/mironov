class AdminAdapter < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    case subject
      when ActiveAdmin::Page
        if action == :read && subject.name == "Dashboard"
          true
        else
          false
        end
      else
        false
    end
  end

end