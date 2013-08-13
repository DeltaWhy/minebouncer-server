MinebouncerServer::Application.routes.draw do
  resources :users, except: [:new, :edit]
  get '/profile', to: 'users#show'
end
