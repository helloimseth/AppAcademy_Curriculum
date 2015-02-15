Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :subs
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create]
end
