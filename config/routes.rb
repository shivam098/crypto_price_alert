Rails.application.routes.draw do
  get '/websocket/prices', to: 'websocket#prices'
  namespace :api do
    resources :alerts, only: [:create, :destroy, :index]
  end
end
