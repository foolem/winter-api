Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :preferences
  resources :messages, except: :create do
    collection do
      match 'create', to: 'messages#create', via: :post, as: 'messages_create'
    end
  end
  resources :chats
  resources :matches
  resources :areas do
    collection do
      match 'sub_areas/:id', to: 'areas#sub_areas', via: :get, as: 'areas_sub_areas'
    end
  end
  resources :sub_areas do
    collection do
      match '/:id/preferences', to: 'sub_areas#preferences', via: :get, as: 'sub_areas_preferences'
    end
  end
  scope '/user' do
    match 'timeline', to: 'users#timeline', via: :get, as: 'user_timeline'
    match 'single_user_timeline', to: 'users#single_user_timeline', via: :get, as: 'user_single_user_timeline'
    match 'matches', to: 'users#matches', via: :get, as: 'user_matches'
    match 'matches/:match_id/messages', to: 'users#chat_messages', via: :get, as: 'user_chat_messages'
    match 'preferences', to: 'users#preferences', via: :get, as: 'user_preferences'
    match 'common_preferences/:id', to: 'users#common_preferences', via: :get, as: 'user_common_preferences'
    match 'top_5', to: 'users#top_5', via: :get, as: 'user_top_5'
    match 'like/:id', to: 'users#like', via: :post, as: 'user_like'
    match 'reject/:id', to: 'users#reject', via: :post, as: 'user_reject'
    match 'choose_preference/:id', to: 'users#choose_preference', via: :post, as: 'user_choose_preference'
    match 'info/:id', to: 'users#info', via: :get, as: 'user_info'
  end


end
