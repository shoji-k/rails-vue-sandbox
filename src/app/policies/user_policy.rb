class UserPolicy < ApplicationPolicy
  default_rule :index?
  alias_rule :update?, :destroy?, to: :edit?

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def edit?
    return true if user.system_role?

    user.id == record.id
  end
end
