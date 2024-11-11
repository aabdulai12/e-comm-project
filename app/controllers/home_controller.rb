class HomeController < ApplicationController

  def index
    @products = Product.order("id DESC").limit(9).page(params[:page]).per(3)
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
  end

  def search
    # This action can render the search form
  end

  def search_results
    # Retrieve selected category and keywords
    @products = Product.all

    if params[:keywords].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", 
                                  "%#{params[:keywords]}%", "%#{params[:keywords]}%")
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.page(params[:page])
  end

  def page
    @page = Page.find(params[:id])
  end

  def sale
    @products = Product.where.not(sale_price: nil).page(params[:page])
  end

  def new
    @products = Product.order("id DESC").limit(9).page(params[:page])
  end

  def cart
    @provinces = Province.all
  end

  def checkout
    session[:checkout] = [
      params[:province], params[:first_name], params[:last_name], params[:email],
      params[:address], params[:city], params[:postal]
    ]
  end

  def create
    province_id, first_name, last_name, email, address, city, postal = session[:checkout]

    # Create new customer
    province = Province.find(province_id)
    new_customer = Customer.create(
      first_name: first_name, last_name: last_name, email: email,
      address: address, city: city, postal_code: postal, province: province
    )

    # Create order
    processing = Status.find_by(title: 'Processing')
    total_price = calculate_total_price(@cart_products, province)

    new_order = new_customer.orders.create(
      gst_rate: province.gst, pst_rate: province.pst, hst_rate: province.hst,
      status: processing, order_total: total_price
    )

    # Clear sessions and redirect
    session[:checkout] = session[:cart] = nil
    flash[:success_message] = "Your order has been placed!"
    redirect_to root_path
  end

  def empty_cart
    session[:cart] = nil
    flash[:error_message] = "Your cart has been emptied."
    redirect_to cart_path
  end

  def edit_cart
    flash[:error_message] = "Please enter your customer details."
    session[:checkout] = nil
    redirect_to cart_path
  end

  def add_product
    session[:cart] << params[:id].to_i unless session[:cart].include?(params[:id].to_i)
    flash[:success_message] = "The product has been added to your cart!"
    redirect_to root_path
  end

  def remove_product
    session[:cart].delete(params[:id].to_i)
    flash[:error_message] = "The product has been removed from your cart!"
    redirect_to cart_path
  end

  private

  def calculate_total_price(products, province)
    total_price = products.sum(&:price)
    total_price += total_price * province.gst if province.gst
    total_price += total_price * province.pst if province.pst
    total_price += total_price * province.hst if province.hst
    total_price
  end
end
