
require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => "/sidekiq"

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, param: :_username
  resources :alerts
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
