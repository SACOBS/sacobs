class ClientPolicy < ApplicationPolicy

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
