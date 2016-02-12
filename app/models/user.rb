 class User < ActiveRecord::Base
   enum role: [:free_user, :premium_user, :admin]
   after_initialize :set_default_role, :if => :new_record?

   def set_default_role
     self.role ||= :free_user
   end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
