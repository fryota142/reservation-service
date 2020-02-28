Rails.application.routes.draw do
  root 'top#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :fp_users
  resources :reservations
  resources :calendars
  get '/events', to: 'reservations#events'
  
end
