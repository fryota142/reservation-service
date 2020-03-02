Rails.application.routes.draw do
  root 'top#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :fp_users
  resources :reservations do
    patch 'user_update', on: :collection
  end
  resources :calendars
  get '/events', to: 'reservations#events'
  post '/events/create', to: 'reservations#event_create'

end
