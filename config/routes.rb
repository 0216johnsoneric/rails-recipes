Rails.application.routes.draw do
  resources :ingredients
  resources :measurements
  resources :pets
  resources :recipes
  resources :users, except: [:new] do 
    resources :recipes, only: [:show, :index, :new, :destroy]
    resources :pets, only: [:show, :new, :destroy]
  end
  get '/auth/:provider/callback' => 'sessions#omniauth'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  root to: 'welcome#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
