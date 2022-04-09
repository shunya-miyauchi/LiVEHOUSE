Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :livehouses do
    resources :events, only: %i[index show]
  end
  resources :users, only: %i[show]
  root 'livehouses#index'
end
