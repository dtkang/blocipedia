class ChargesController < ApplicationController

  def create
    customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
        )

    charge = Stripe::Charge.create(
        customer: customer.id,
        amount: 1500,
        description: "Blocipedia Membership - #{current_user.email}",
        currency: 'usd'
        )
      
    flash[:notice] = "Thank you for your payment, #{current_user.email}!"

    current_user.role = "premium"
    if current_user.save!
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = "Error occurred during upgrade, please try again."
      redirect_to new_charge_path
    end

  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_charge_path
  end
  
  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Blocipedia Membership - #{current_user.email}",
        amount: 1500
    }
  end
  
  def edit
    current_user.role = "standard"
    
    private_wikis = Wiki.where({private: true, user_id: current_user.id})

    private_wikis.each do |wiki|
      wiki.private = false
      wiki.save!
    end
   
    if current_user.save!
      flash[:notice] = "Downgrade complete!"
    else
      flash.now[:alert] = "Error occurred during downgrade, please try again!"
    end
    
    redirect_to welcome_index_path
  end
  
end
