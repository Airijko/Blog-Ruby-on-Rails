Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  get "sign_out", to: "application#sign_out_user"

  root "home#index"

  get "/reviews", to: "reviews#index"
  get "/reviews/new", to: "reviews#new"
  post "/reviews/new", to: "reviews#create"

  get "/search", to: "search#index"
  get "/summoners/:region/:gameName-:tagLine", to: "summoners#show", as: "summoner"
end
