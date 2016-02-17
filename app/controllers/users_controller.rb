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

    flash[:notice] = "Your refund has been issued, and your account has been downgraded."
    current_user.update_attributes :role => 0, :refund_id => refund.id
    redirect_to wikis_path
  end
end
