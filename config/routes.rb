Rails.application.routes.draw do

  root 'static#home'

  devise_for :traders, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :traders, only: [:index] do
    resources :trades, only: [:show, :index]
  end

  resources :instruments, only: [:index, :show] do
    resources :trades, only: [:show, :index]
  end

  resources :trades

end
