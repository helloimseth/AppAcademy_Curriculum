Rails.application.routes.draw do
  root to: 'root#root'

  resources :posts, except: [:new, :edit]
end
