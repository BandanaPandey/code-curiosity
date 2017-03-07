class Ability
  include CanCan::Ability

  def initialize(user, only_sponsorer, current_role)
    user ||= User.new
    
    if user && only_sponsorer
        can :manage, :sponsorers
    elsif user && current_role == 'Sponsorer'
        can :manage, :sponsorers
        can :show, User
    elsif user && current_role == 'User'
        can :manage, :all
        cannot :manage, :sponsorers
    elsif user && user.is_admin?
         can :manage, :all
         cannot :manage, :sponsorers 
    else
        can :manage, :all
        cannot :manage, :sponsorers  
    end
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
