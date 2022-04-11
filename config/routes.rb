Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :livehouses, only: %i[index] do
    resources :events, only: %i[index show]
  end
  resources :favorites, only: %i[index show]
  resources :users, only: %i[show] do
    member do
      get 'future_events'
      get 'past_events'
    end
  end
  resources :favorites, only: %i[create destroy]
  root 'livehouses#index'
end
