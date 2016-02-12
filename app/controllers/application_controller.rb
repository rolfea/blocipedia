class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

    def user_not_authorized
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
end
