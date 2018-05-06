Rails.application.routes.draw do
  root to: 'application#index'
  get 'login' => 'user/authentications#new', as: :new_user_authentication
  post 'login' => 'user/authentications#create', as: :user_authentications
  get 'logout' => 'user/authentications#destroy', as: :destroy_user_authentication
end
