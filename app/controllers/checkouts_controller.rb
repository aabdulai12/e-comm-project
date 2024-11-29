class CheckoutsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_cart, only: [:new, :create, :show]
    
    def new
      @checkout = Checkout.new
      @user = current_user
      @cart = current_user.cart
      @total_price = @cart.total_price
      @addresses = @user.addresses
    end
  
    def create
      @checkout = Checkout.new(checkout_params)
      @checkout.user = current_user
      @checkout.cart = @cart
      @checkout.total = @cart.total_price  # Ensure the total is set
      
      # Set a default status, e.g., "pending" if no status is provided
      @checkout.status ||= "pending"  # Set default status if nil
      
      if @checkout.save
        # Process the payment
        process_payment(@checkout)
        
        redirect_to checkout_success_path, notice: 'Your order has been successfully placed!'
      else
        # Render the 'new' view with error messages
        render :new
      end
    end
  
    private
  
    def checkout_params
      params.require(:checkout).permit(:address_id, :payment_method, :shipping_method, :note)
    end
  
    def process_payment(checkout)
      # Placeholder payment logic
      checkout.update(payment_status: "paid")
      current_user.cart.empty!
    end
    
    def set_cart
      @cart = current_user.cart
    end
  end
  