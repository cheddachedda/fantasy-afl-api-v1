Rails.application.routes.draw do
  resources :clubs, only: [:index, :show]
end
