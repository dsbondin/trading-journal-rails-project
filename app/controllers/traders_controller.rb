class TradersController < ApplicationController

  def index
    @traders = Trader.all
  end

  def show
    @trader = Trader.find_by(params[:id])
  end

end
