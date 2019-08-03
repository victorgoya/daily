Rails.application.routes.draw do
	root to: "variations#index"

  get 'users', to: 'users#create', as: :create_user
  post 'logout', to: 'users#logout'

  resources :users, only: [:new, :update, :edit, :destroy]
  resources :variations, only: [:create, :new, :edit, :update, :destroy]

  get '/privacy-policy', to: "pages#privacy_policy", as: :privacy_policy
  get '/terms-and-conditions', to: "pages#terms_and_conditions", as: :terms_and_conditions
  
  get '/:range', to: "variations#index", as: :variations_range
end
