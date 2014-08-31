Binder::Application.routes.draw do
  ##
  # JSON
  #

  resources :artists, only: [:index]
  resources :songs,   only: [:index]

  ##
  # HTML
  #

  # Home
  authenticated do
    root to: 'jams#index', as: :authenticated_root
  end
  unauthenticated do
    root to: 'high_voltage/pages#show', id: 'home'
  end

  # Authentication
  devise_for :users

  # RESTful
  resources :users, only: [] do
    resources :jams, only: [:index, :new, :create]
  end

  # Chipotle
  get '/burrito',  to: redirect('https://order.chipotle.com/')
  get '/burritos', to: redirect('https://order.chipotle.com/')
  get '/tacos',    to: redirect('https://order.chipotle.com/')
end
