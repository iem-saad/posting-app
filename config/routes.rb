Rails.application.routes.draw do
  get 'sessions/new'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login' , to: 'sessions#new'
  post '/login' , to: 'sessions#create'
  delete '/logout' , to: 'sessions#destroy' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    member do 
      get :following, :followers
    end
  end
  resources :posts
  #root "users#index"
  root "static_pages#home"
  resources :account_activation, only: [:edit]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
