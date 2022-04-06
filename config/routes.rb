Rails.application.routes.draw do
  devise_for :users
  root 'livehouses#index'
  resources :livehouses do
    resources :events, only: %i[index show]
  end
end
