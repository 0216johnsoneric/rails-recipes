Rails.application.routes.draw do
  resources :ingredients
  resources :measurements
  resources :foods
  resources :recipes
  resources :users, except: [:new] do 
    resources :recipes, only: [:show, :index, :new, :destroy]
    resources :foods, only: [:show, :new, :destroy]
  end
  get '/auth/:provider/callback' => 'sessions#omniauth'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  root to: 'welcome#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
