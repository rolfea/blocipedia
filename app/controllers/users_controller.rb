class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted"
  end

  def downgrade
    refund = Stripe::Refund.create(
      charge: current_user.last_charge_id
    )

    flash[:notice] = "Your refund has been issued, and your account has been downgraded. \n All private wikis are now public."
    current_user.update_attributes :role => 0, :refund_id => refund.id
    Wiki.where(user_id: current_user.id).find_each do |wiki|
      wiki.update(private: false)
    end
    redirect_to wikis_path
  end
end
