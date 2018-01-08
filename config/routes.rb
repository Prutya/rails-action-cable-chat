Rails.application.routes.draw do
  root 'messages#index'

  resources :messages, only: %i[index create]
  resources :users,    only: %i[new create]

  resource  :session, only: %i[new create destroy]

  mount ActionCable.server, at: '/cable'
end
