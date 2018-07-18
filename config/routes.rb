Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static#home"
  get '/users/most_recipes', to: 'users#most_recipes'
  resources :users do
    resources :recipes
  end
  resources :recipes do
    resources :comments
  end

  get '/auth/facebook/callback', to: 'sessions#create_facebook'
  get "/signin", to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"
end
