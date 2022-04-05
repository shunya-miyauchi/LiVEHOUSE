Rails.application.routes.draw do
  resources :livehouses do
    resources :events, only: %i(index show)
  end
end
