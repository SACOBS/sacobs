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

  Scope = Struct.new(:user, :scope) do
    def resolve
      scope
    end
  end
end
