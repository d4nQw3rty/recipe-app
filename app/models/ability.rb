class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= ::User.new
    can :read, :all
    return unless user.present?

    can(:manage, Food, user:)
    can(:manage, Recipe, user:)
    can :manage, RecipeFood, :all
  end
end
