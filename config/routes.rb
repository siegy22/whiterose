Rails.application.routes.draw do
  root "conversations#index"

  resources :conversations, only: [:new, :create, :show] do
    get :pgp, on: :member
    get :download_pgp, on: :member
  end
  resources :messages, only: [:create, :destroy]
  resource :pgp, only: [:edit, :update]
  devise_for :users
end
