class VariationPolicy < ApplicationPolicy
  def create?
    user == record.user
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
