PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy', as: :logout
  get 'signup', to: 'users#new', as: :signup


  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end

  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:create]
end

