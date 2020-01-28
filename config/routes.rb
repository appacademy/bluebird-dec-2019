Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'
  # post '/users', to: 'users#create'
  # patch '/users/:id', to: 'users#update'
  # delete '/users/:id', to: 'users#destroy'

  resources :users do
    resources :chirps, only: [:index]
  end

  resources :chirps, only: [:show]
  resource :session, only: [:new, :create, :destroy]

  post "/search", to: "searches#create"
  get "/search", to: "searches#new"
  get "/get_searches", to: "searches#get_data"

  get "/set_cookie", to: "cookies_demo#set_cookie"
  get "/get_cookie", to: "cookies_demo#get_cookie"
  
end
