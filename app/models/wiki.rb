class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :collaborators
  has_many :users, :through => :collaborators
  belongs_to :user
end
