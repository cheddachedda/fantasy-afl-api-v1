Rails.application.routes.draw do
  resources :clubs, only: [:index, :show]

  resources :fixtures, only: [:index]
  get '/fixtures/:round' => 'fixtures#round', as: 'round'
  get '/fixtures/:round/:id' => 'fixtures#show', as: 'fixture'

  resources :players, only: [:index, :show]
end
