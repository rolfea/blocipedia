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
    current_user.free!
    flash[:notice] = "You have been downgraded to a free account."
    redirect_to wikis_path
  end
end
