 class User < ActiveRecord::Base
   extend FriendlyId
   friendly_id :email, use: :slugged

   enum role: [:free, :premium, :admin]
   after_initialize :set_default_role, :if => :new_record?

   has_many :collaborators
   has_many :wikis, :through => :collaborators

   def set_default_role
     self.role ||= :free
   end

   def own_wikis
     Wiki.where(user: self)
   end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
