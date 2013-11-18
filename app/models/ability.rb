class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new     

    can :update, Opinion, :user_id => user.id
  end
end
