class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, :through => :collaborators

  scope :visible_to, -> (current_user) { current_user.premium? || current_user.admin? ? all : where(private: false) }
end
