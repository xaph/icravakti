Icravakti::Application.routes.draw do
  resources :borrowers

  resources :loans do
    resources :payments do
      get 'toggle_paid'
    end
    post 'create_payment_plan'
    get 'archive'
  end

  get "user/show"

  get "user/edit"
  get "user/twitter_signup"

  get "user/update"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "home/index"

  root :to => 'home#index'
end
