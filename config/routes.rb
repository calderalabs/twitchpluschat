Rails.application.routes.draw do
  resources :videos, only: :show
  resources :emoticons, only: :index

  root to: 'application#index'
  get '*path' => 'application#index'
end
