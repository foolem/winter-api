Rails.application.routes.draw do
  resources :preferences
  resources :messages
  resources :chats
  resources :matches
  resources :sub_areas
  resources :areas
  mount_devise_token_auth_for 'User', at: 'auth'
  get 'user/timeline', to: 'users#timeline', as: 'user_timeline'
  get 'user/matches', to: 'users#matches', as: 'user_matches'
  get 'user/preferences', to: 'users#preferences', as: 'user_preferences'
  post 'user/like/:id', to: 'users#like', as: 'user_like'
  post 'user/reject/:id', to: 'users#reject', as: 'user_reject'


end
