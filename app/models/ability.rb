class Ability
  include CanCan::Ability



  def initialize(admin_user)
    can :read, AdminMain
    if admin_user.plan_admin?
      can :manage, Asrt
    end
    if admin_user.cash_admin?
      can :manage, Cash
      can :manage, Cashc
      can :manage, Balance
    end
    if admin_user.implementation_admin?
      can :manage, Implementation
    end

    if admin_user.super_admin?
      can :manage, :all
    end

  end
end
