class UserPolicy < ApplicationPolicy
  def update?
    user == record
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
