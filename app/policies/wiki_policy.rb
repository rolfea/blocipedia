class WikiPolicy < ApplicationPolicy
  
  class Scope
    attr_reader :user, :scope

    def initialize
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end

  def update?
    user.admin? or not wiki.published?
end
