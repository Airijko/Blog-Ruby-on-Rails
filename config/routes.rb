Rails.application.routes.draw do
  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'

  root 'home#index'

  get '/reviews', to: 'reviews#index'
  get '/reviews/new', to: 'reviews#new'
  post '/reviews/new', to: 'reviews#create'

  get '/search', to: 'search#index'
  get '/summoners/:region/:game_name-:tag', to: 'summoners#show', as: 'summoner'
end
