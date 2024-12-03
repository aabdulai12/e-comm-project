class SearchController < ApplicationController
  # Load products of a specific category
  def category
    @category = Category.find(params[:id])
    @products = Product.where(category_id: params[:id]).page(params[:page])
  end
end
