# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    can :read, Article

    return unless user.present?

    can [:create, :update, :delete], Article, user: user

    return unless user.admin?

    can :manage, :all

  end
end
