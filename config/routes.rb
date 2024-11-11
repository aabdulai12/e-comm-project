RailsEcommProject::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  get "home/index"

  # Index of the site
  root to: "home#index"

  # Route to product pages
  get 'home/:id', to: 'home#show', as: :store_product

  # Route to pages
  get 'page/:id', to: 'home#page', as: 'page'
  get 'search/:id', to: 'search#category', as: 'category'

  # On Sale
  get 'sale', to: 'home#sale', as: 'sale'
  get 'new', to: 'home#new', as: 'new'

  # Search routes
  get 'search', to: 'home#search', as: 'search'
  get 'search_results', to: 'home#search_results', as: 'search_results'
  post 'search_results', to: 'home#search_results'

  # Shopping cart route
  get 'cart', to: 'home#cart', as: 'cart'
  get 'empty', to: 'home#empty_cart', as: 'empty_cart'
  get 'add_product/:id', to: 'home#add_product', as: 'add_product'
  get 'remove_product/:id', to: 'home#remove_product', as: 'remove_product'
  post 'checkout', to: 'home#checkout', as: 'checkout'
  post 'create', to: 'home#create', as: 'create'
  get 'edit_cart', to: 'home#edit_cart', as: 'edit_cart'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Legacy catch-all route
  # match ':controller(/:action(/:id))(.:format)', via: :all

  # root :to => "home#index"
end
