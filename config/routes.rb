Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :livehouses do
    resources :events, only: %i[index show]
  end
  resources :users, only: %i[show]
  resources :favorites, only: %i[create destroy]
  root 'livehouses#index'
end
