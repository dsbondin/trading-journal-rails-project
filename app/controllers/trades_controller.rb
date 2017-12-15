class TradesController < ApplicationController

  def index
    if id = params[:trader_id]
      @trades = Trader.find_by(id: id).trades
    elsif id = params[:instrument_id]
      @trades = Instrument.find_by(id: id).trades
    else
      @trades = Trade.all
    end
  end

  def new
    @trade = Trade.new
  end

  def create
    remove_empty_symbol
    @trade = current_trader.trades.build(trade_params)
    if @trade.save
      redirect_to trade_path(@trade)
    else
      render :new
    end
  end

  def show
    @trade = Trade.find_by(id: params[:id])
  end

  private
    def trade_params
      params.require(:trade).permit(:direction, :entry, :exit, :quantity, :instrument_id, instrument_attributes: [:symbol])
    end

    def remove_empty_symbol
      params[:trade].delete(:instrument_attributes) if params[:trade][:instrument_attributes][:symbol] == ""
    end

end
