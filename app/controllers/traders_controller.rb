class TradersController < ApplicationController

  def index
    @traders = Trader.all
  end

  def show
    # raise params.inspect
    @trader = Trader.find_by(id: params[:id])
  end

end
