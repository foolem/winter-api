Rails.application.routes.draw do
  resources :preferences
  resources :messages
  resources :chats
  resources :matches
  resources :sub_areas
  resources :areas
  mount_devise_token_auth_for 'User', at: 'auth'
  get 'users/timeline', to: 'users#timeline', as: 'user_timeline'
  get 'users/matches', to: 'users#matches', as: 'user_matches'

end
