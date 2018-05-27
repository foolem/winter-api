Rails.application.routes.draw do
  resources :preferences
  resources :messages
  resources :chats
  resources :matches
  resources :sub_areas
  resources :areas
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
