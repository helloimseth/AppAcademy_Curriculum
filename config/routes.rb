Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: [:index, :show]
  end
  resources :albums, only: [:new, :create, :destroy, :edit]
end
