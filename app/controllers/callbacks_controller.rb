class CallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @trader = Trader.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @trader
  end

  def github
    @trader = Trader.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @trader
  end

end
