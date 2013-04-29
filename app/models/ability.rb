class Ability
  include CanCan::Ability



  def initialize(admin_user)
    can :read, Assortment
    if admin_user.plan_admin?
      can :manage, Plan
      can :manage, Asrt
      can :manage, Assortment
      can :manage, Quantity
    end
    if admin_user.cash_admin?
      can :manage, Cash
      can :manage, Cashc
      can :manage, Balance
      can :manage, Quantity
    end
    if admin_user.implementation_admin?
      can :manage, Implementation
      can :manage, Direction
      can :manage, Quantity
    end

    if admin_user.super_admin?
      can :manage, :all
    end

  end
end
