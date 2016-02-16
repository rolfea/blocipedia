class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Membership - #{current_user.email}",
      amount: @amount
    }
  end

  def create
    @amount = 15_00
    # Stripe Customer object
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Membership - #{current_user.email}",
      currency: 'usd'
    )

    # If user already premium_user or admin, error, else upgrade account 
    flash[:notice] = "Thanks for upgrading your account, #{current_user.email}!"

    redirect_to wikis_path

    # Stripe Card Error
  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_charge_path
  end
end
