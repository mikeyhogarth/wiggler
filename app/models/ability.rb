class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new     
    
    can :read, Wiggle
    can :update, Opinion, :user_id => user.id
  end
end
