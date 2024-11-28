RailsEcommProject::Application.routes.draw do
  # Devise user authentication
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # CKEditor
  mount Ckeditor::Engine => '/ckeditor'


# add routes for orders
    resources :orders, only: [:index, :show] do
     member do
     patch :mark_as_paid
    end
  end


  # Root route
  root 'home#index' # Defines the homepage
  post 'place_order', to: 'home#place_order', as: 'place_order'

  # Home and product-related routes
  get 'home/index'
  get 'products/search', to: 'products#search', as: 'product_search'
  patch 'update_cart/:id', to: 'home#update_cart', as: 'update_cart'
  resources :orders, only: [:index]
  get 'thank_you', to: 'home#thank_you', as: 'thank_you'
  delete 'remove_product/:id', to: 'home#remove_product', as: 'remove_product'
  delete 'empty', to: 'home#empty_cart', as: 'empty_cart'

  # Route to product detail page
  get 'home/:id', to: 'home#show', as: :store_product

  # Checkout routes
  # Renaming resources :checkout to avoid conflict with custom routes
  resources :checkouts, only: [:new, :create, :show], as: :order_checkout
  get 'checkout/success', to: 'home#checkout_success', as: 'checkout_success'
  get 'checkout/cancel', to: 'home#checkout_cancel', as: 'checkout_cancel'
  post 'checkout', to: 'home#checkout', as: 'process_checkout'

  # PayPal route
  post 'paypal_checkout', to: 'home#paypal_checkout', as: 'paypal_checkout'

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
  #get 'empty', to: 'home#empty_cart', as: 'empty_cart'
  get 'add_product/:id', to: 'home#add_product', as: 'add_product'
 # get 'remove_product/:id', to: 'home#remove_product', as: 'remove_product'

  # Additional checkout routes
  post 'create', to: 'home#create', as: 'create'
  get 'edit_cart', to: 'home#edit_cart', as: 'edit_cart'
end
