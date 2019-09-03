Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'artists/profile', to: 'artists#profile', as: :artist_profile
  get 'artists/edit_profile', to: 'artists#edit_profile', as: :edit_profile
  patch 'artists/update_profile', to: 'artists#update_profile', as: :update_profile
  post 'artists/upload_paintings', to: 'artists#upload_paintings', as: :upload_paintings
  post 'artists/mark_public', to: 'artists#mark_public', as: :mark_public
  
  root to: "home#index"
end
