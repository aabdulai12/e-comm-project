RailsEcommProject::Application.routes.draw do
  # Devise user authentication
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # CKEditor
  mount Ckeditor::Engine => '/ckeditor'

  # Root route
  root 'home#index' # Defines the homepage
  

  # Home and product-related routes
  get 'home/index'
  get 'products/search', to: 'products#search', as: 'product_search'
  patch 'update_cart/:id', to: 'home#update_cart', as: 'update_cart'
  resources :orders, only: [:index]

  # Route to product detail page
  get 'home/:id', to: 'home#show', as: :store_product

  # Static pages
  get 'page/:id', to: 'home#page', as: 'page'
  get 'search/:id', to: 'search#category', as: 'category'

  # Sales and new products
  get 'sale', to: 'home#sale', as: 'sale'
  get 'new', to: 'home#new', as: 'new'

  # Search routes
  get 'search', to: 'home#search', as: 'search'
  get 'search_results', to: 'home#search_results', as: 'search_results'
  post 'search_results', to: 'home#search_results'

  # Shopping cart routes
  get 'cart', to: 'home#cart', as: 'cart'
  get 'empty', to: 'home#empty_cart', as: 'empty_cart'
  get 'add_product/:id', to: 'home#add_product', as: 'add_product'
  get 'remove_product/:id', to: 'home#remove_product', as: 'remove_product'
  post 'checkout', to: 'home#checkout', as: 'checkout'
  post 'create', to: 'home#create', as: 'create'
  get 'edit_cart', to: 'home#edit_cart', as: 'edit_cart'

  # Remove legacy catch-all route as it’s no longer recommended in Rails.
end
