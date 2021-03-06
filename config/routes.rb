Rails.application.routes.draw do
  root 'chat#index'

  resources :messages, only: %i[index create]
  resources :users,    only: %i[new create]

  resource  :session, only: %i[new create destroy]

  get '/chat', to: 'chat#index'

  mount ActionCable.server, at: '/cable'
end
