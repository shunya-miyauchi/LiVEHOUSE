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
  resources :users, only: %i[show] do
    member do
      get 'past_joins'
    end
  end
  resources :favorites, only: %i[index show create destroy]
  resources :joins, only: %i[create destroy]
  
  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  # ルート
  root 'livehouses#index'
end
