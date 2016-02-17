class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :visible_to, -> (current_user) { current_user.premium? || current_user.admin? ? all : where(private: false) }
end
