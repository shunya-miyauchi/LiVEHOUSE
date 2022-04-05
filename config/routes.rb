Rails.application.routes.draw do
  root "livehouses#index"
  resources :livehouses do
    resources :events, only: %i(index show)
  end
end
