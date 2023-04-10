# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    can :read, Article

    return unless user.present?

    can [:create, :update, :delete], Article, user: user

    can :create, Comment

    can :destroy, Comment do |comment|
      comment.article.user == user
    end

    return unless user.admin?

    can :manage, :all
  end
end
