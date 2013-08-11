Binder::Application.routes.draw do
  authenticated do
    root to: 'songs#index', as: :authenticated_root
  end
  unauthenticated do
    root to: 'high_voltage/pages#show', id: 'home'
  end

  get '/burrito',  to: redirect('https://order.chipotle.com/')
  get '/burritos', to: redirect('https://order.chipotle.com/')
  get '/tacos',    to: redirect('https://order.chipotle.com/')

  devise_for :users

  resources :users, :path => '', only: [] do
    resources :songs, only: [:index, :new, :create, :destroy]
  end

  resources :songs, only: [:index]

  resources :artists, only: [:index]

  get '/:user_id', to: 'songs#index', as: :user_song_list
end
