Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'

  devise_for :users

  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end

  resources :events do
    resources :charges
  end

end
