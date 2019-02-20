Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  resources :posts do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
