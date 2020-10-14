Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/register", to: "users#new"
  post "/register", to: "users#create"

  get "/dashboard", to: "users#show"

  get '/discover', to: 'discover#index'

  get '/movies', to: 'movies#index'
  get '/movies/:id', to: 'movies#show'

  post "/friendships", to: "friendships#create"

  get '/parties/new', to: 'parties#new'
  post '/parties', to: 'parties#create'
end
