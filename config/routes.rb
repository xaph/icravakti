Icravakti::Application.routes.draw do
  get "user/show"

  get "user/edit"
  get "user/twitter_signup"

  get "user/update"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "home/index"

  root :to => 'home#index'
end
