Rails.application.routes.draw do

  devise_for :traders
  root 'static#home'

end
