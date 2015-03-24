Rails.application.routes.draw do
  root to: 'root#root'

  resources :posts,
    defaults: { format: :json },
    except: [:new, :edit]
end
