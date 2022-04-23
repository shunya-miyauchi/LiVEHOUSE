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
  resources :users, only: %i[show]
  resources :favorites, only: %i[index create destroy]
  resources :joins, only: %i[create destroy]
  resources :blogs

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end

  # ルート
  root 'livehouses#index'
end
