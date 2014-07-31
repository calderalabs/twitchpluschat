Rails.application.routes.draw do
  resources :videos, only: :show
  resources :emoticon_sets, only: :index
  resources :messages, only: :index

  root to: 'root#index'
  get '*path' => 'root#index'
end
