class BusPolicy < ApplicationPolicy


  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def new?
    create?
  end

  def create?
    user.admin?
  end

  def edit?
    update?
  end

  def update?
    user.admin? && !record.trips.any?(&:booked?)
  end

  def destroy?
    user.admin? && !record.trips.any?(&:booked?)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope
      else
        scope.none
      end
    end
  end
end
