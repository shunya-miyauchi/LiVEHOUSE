Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :livehouses, only: %i[index] do
    resources :events, only: %i[index show] do
      resources :comments, only: %i[create]
    end
  end
  resources :favorites, only: %i[index show]
  resources :users, only: %i[show] do
    member do
      get 'past_joins'
    end
  end
  resources :favorites, only: %i[create destroy]
  root 'livehouses#index'
end
