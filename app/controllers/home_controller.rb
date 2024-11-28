class HomeController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in
  before_action :set_cart, only: [:checkout, :place_order]


  def index # 
    @products   = Product.order("id DESC").limit(9).page(params[:page]).per(3)
  end # Load the app/views/home/index

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
  end # Load the app/views/home/show

  def search
    # No Code Required
  end

  def search_results
    # Trying to implement category search
    @category = Category.where("title LIKE ?", "%#{params[:keywords]}%")

    if ( @category.first.nil? )
      @products = Product.where("name LIKE ? OR description LIKE ?", 
                              "%#{params[:keywords]}%", "%#{params[:keywords]}%").page(params[:page])
    else
      @products = Product.where("name LIKE ? OR description LIKE ? OR category_id LIKE ?", 
                                "%#{params[:keywords]}%", "%#{params[:keywords]}%", "%#{@category.first.id}%").page(params[:page])
    end
  end

  def page # Find a specific page based on the id sent
    @page = Page.find(params[:id])
  end

  def sale # Find products that are on sale
    @products = Product.where("sale_price IS NOT NULL").page(params[:page])
  end

  def new #Find the last 5 products added
    @products = Product.order("id DESC").limit(9).page(params[:page])
  end

  def cart
    # Ensure that @cart_products is populated correctly
    product_ids = session[:cart].keys if session[:cart].is_a?(Hash)
    @cart_products = Product.where(id: product_ids)
  
    # Load provinces for the dropdown
    @provinces = Province.all

  end




  # Initialize or retrieve the user's cart
  def set_cart
    session[:cart] ||= {} # Ensure session[:cart] is always a hash
    product_ids = session[:cart].keys
    @cart_products = Product.where(id: product_ids)
  end
  
  def checkout
    @order = current_user.orders.find(params[:order_id])
    # Fetch user input from params
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @address = params[:address]
    @province_id = params[:province]
    @city = params[:city]
    @email = params[:email]
    @postal = params[:postal]
  
    # Validate that all fields are provided
    if [@first_name, @last_name, @address, @province_id, @city, @email, @postal].any?(&:blank?)
      flash[:error] = "Please fill in all required fields."
      redirect_to cart_path and return
    end
  
    # Retrieve the selected province
    @province = Province.find_by(id: @province_id)
    unless @province
      flash[:error] = "Invalid province selected. Please choose a valid province."
      redirect_to cart_path and return
    end
  
    # Calculate the subtotal and taxes
    @subtotal = @cart_products.sum do |product|
      quantity = session[:cart][product.id.to_s].to_i
      product.price * quantity
    end
  
    @gst_total = @subtotal * (@province.gst || 0)
    @pst_total = @subtotal * (@province.pst || 0)
    @hst_total = @subtotal * (@province.hst || 0)
    @total_amount = @subtotal + @gst_total + @pst_total + @hst_total
  
    # Debugging logs for validation
    Rails.logger.debug "Checkout details: Subtotal=#{@subtotal}, GST=#{@gst_total}, PST=#{@pst_total}, HST=#{@hst_total}, Total=#{@total_amount}"
  end
  
  
  
 
  # app/controllers/home_controller.rb
  def create
  # Log the session data for debugging
  Rails.logger.debug "Session checkout data: #{session[:checkout].inspect}"

  # Check if all required fields are present in session[:checkout]
  if session[:checkout].nil? || session[:checkout].any?(&:blank?)
    flash[:error] = "There was an issue with your session data. Please try again."
    redirect_to cart_path and return
  end

  # Fetch session data for checkout
  province_id, first_name, last_name, email, address, city, postal = session[:checkout]

  # Create and save customer record
  new_customer = Customer.new(
    first_name: first_name,
    last_name: last_name,
    email: email,
    address: address,
    city: city,
    postal_code: postal,
    province_id: province_id
  )

  if new_customer.save
    # Calculate base total from cart items
    total_price = 0
    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      total_price += product.price * quantity
    end

    # Fetch province and tax rates
    province = new_customer.province
    gst_rate = province&.gst || 0
    pst_rate = province&.pst || 0
    hst_rate = province&.hst || 0

    # Calculate tax totals and final order total
    gst_total = total_price * gst_rate
    pst_total = total_price * pst_rate
    hst_total = total_price * hst_rate
    order_total = total_price + gst_total + pst_total + hst_total

    # Create and save new order
    new_order = Order.new(
      customer: new_customer,
      status: Status.find_by(title: 'Processing'), # Ensure 'Processing' status exists
      gst_rate: gst_rate,
      pst_rate: pst_rate,
      hst_rate: hst_rate,
      order_total: order_total
    )

    if new_order.save
      # Clear session data for cart and checkout
      session[:checkout] = nil
      session[:cart] = nil

      # Display success message and redirect
      flash[:success] = "Thank you for your order!"
      redirect_to root_path
    else
      # Handle order save failure
      flash[:error] = "There was an issue saving your order. Please try again."
      redirect_to cart_path
    end
  else
    # Handle customer save failure
    flash[:error] = "There was an issue creating your customer profile: #{new_customer.errors.full_messages.join(', ')}"
    redirect_to cart_path
  end


    
  
  def checkout_success
    payment_id = params[:paymentId]
    payer_id = params[:PayerID]
  
    payment = PayPal::SDK::REST::Payment.find(payment_id)
  
    if payment.execute(payer_id: payer_id)
      # Clear the cart and show success message
      session[:cart] = nil
      flash[:success] = "Payment completed successfully. Thank you for your order!"
      redirect_to orders_path
    else
      flash[:error] = "Payment could not be processed. Please try again."
      redirect_to cart_path
    end
  end
  
  def checkout_cancel
    flash[:error] = "Payment was canceled."
    redirect_to cart_path
  end
  
  end


  
  def place_order
    province = Province.find(params[:province])
    subtotal = @cart_products.sum do |product|
      quantity = session[:cart][product.id.to_s].to_i
      product.price * quantity
    end
  
    order = current_user.orders.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      address: params[:address],
      city: params[:city],
      postal_code: params[:postal],
      province: province,
      subtotal: subtotal,
      status: Status.find_by(title: 'unpaid')
    )
  
    if order.persisted?
      session[:cart].each do |product_id, quantity|
        product = Product.find(product_id)
        order.order_items.create!(
          product: product,
          quantity: quantity,
          price: product.price
        )
      end
  
      session[:cart] = nil
      flash[:success] = "Order placed successfully!"
      redirect_to orders_path
    else
      flash[:error] = "There was an issue placing your order: #{order.errors.full_messages.join(', ')}"
      redirect_to cart_path
    end
  end
  


  def empty_cart
    session[:cart] = nil
    flash[:error_message] = "Your cart has been emptied.."
    redirect_to cart_path
  end

  def edit_cart
    flash[:error_message] = "Please enter your customer details..."
    session[:checkout] = nil
    redirect_to cart_path
  end

  def add_product
    product_id = params[:id].to_s
  
    # Force `session[:cart]` to be a hash if it's not already one
    unless session[:cart].is_a?(Hash)
      session[:cart] = {}
    end
  
    # Safely increment the product's quantity or initialize it to 1 if not present
    session[:cart][product_id] = (session[:cart][product_id].to_i || 0) + 1
  
    flash[:success_message] = "The product has been added to your cart!"
    redirect_to root_path
  end
  
  

  def remove_product
    product_id = params[:id].to_s
    if session[:cart] && session[:cart][product_id]
      session[:cart].delete(product_id)
      flash[:notice] = "Product successfully removed from your cart."
    else
      flash[:alert] = "Product not found in your cart."
    end
    redirect_back(fallback_location: root_path)
  end

  def update_cart
    product_id = params[:id].to_s
    new_quantity = params[:quantity].to_i
  
    # Update the cart with the new quantity or remove the item if quantity is zero
    if new_quantity > 0
      session[:cart][product_id] = new_quantity
    else
      session[:cart].delete(product_id)
    end
  
    flash[:success_message] = "Cart updated successfully!"
    redirect_to cart_path
  end
  
  def thank_you
  end
  def test_flash
    flash[:notice] = "This is a test flash message!"
    redirect_to root_path
  end
  end


  def stripe_checkout
  # Set your secret key: remember to change this to your live secret key in production
  Stripe.api_key = Rails.application.credentials.stripe[:secret_key]

  token = params[:stripe_token]

  begin
    charge = Stripe::Charge.create({
      amount: (total + gst_total + pst_total + hst_total) * 100, # Amount in cents
      currency: 'cad',
      description: 'Order Payment',
      source: token,
    })

    if charge.paid
      # Update order status, etc.
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
