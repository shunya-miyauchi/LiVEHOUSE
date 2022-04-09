Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  root 'livehouses#index'
  resources :livehouses do
    resources :events, only: %i[index show]
  end
  resources :user, only: %i[show]
end
