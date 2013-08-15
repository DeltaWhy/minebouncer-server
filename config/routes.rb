MinebouncerServer::Application.routes.draw do
  resources :games, except: [:new, :edit, :update]
  resources :users, except: [:new, :edit] do
    resources :games, except: [:new, :edit, :update]
  end
  get '/profile', to: 'users#show'
end
