Rails.application.routes.draw do
  root 'home#index'

  get '/reviews', to: 'reviews#index'
  get '/reviews/new', to: 'reviews#new'
  post '/reviews/new', to: 'reviews#create', as: 'create_post'
end
