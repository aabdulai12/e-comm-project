module Admin
  class CustomersController < ApplicationController
    before_action :authenticate_admin! # Ensure only admins can access this page

    def index
      @customers = Customer.includes(orders: :line_items)
    end

    def authenticate_admin_user!
      redirect_to root_path, alert: "Access Denied!" unless current_user&.admin?
    end
  end
end
