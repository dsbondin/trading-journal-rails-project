class TradesController < ApplicationController

  def index
    if id = params[:trader_id]
      @trades = Trader.find_by(id: id).trades
      render :trader_trades
    elsif id = params[:instrument_id]
      @trades = Instrument.find_by(id: id).trades
      render :instrument_trades
    else
      @trades = Trade.all
    end
  end

  def show
    set_trade
  end

  def new
    @trade = Trade.new
  end

  def create
    @trade = current_trader.trades.build(trade_params)
    if @trade.save
      redirect_to trader_trade_path(current_trader, @trade)
    else
      render :new
    end
  end

  def edit
    set_trade
  end

  def update
    set_trade
    if @trade.trader == current_trader
      if @trade.update(trade_params)
        redirect_to trade_path(@trade)
      else
        render :edit
      end
    else
      redirect_to :index
    end
  end

  def destroy
    set_trade
    @trade.delete if @trade.trader == current_trader
    redirect_to trader_trades_path(current_trader)
  end

  def best
    @trade = Trade.most_profitable
    render :show
  end

  def worst
    @trade = Trade.least_profitable
    render :show
  end


  private
    def set_trade
      @trade = Trade.find_by(id: params[:id])
    end

    def trade_params
      params.require(:trade).permit(:direction, :entry, :exit, :quantity, :notes, :instrument_id, instrument_attributes: [:symbol])
    end

    # def remove_empty_symbol
    #   params[:trade].delete(:instrument_attributes) if params[:trade][:instrument_attributes][:symbol] == ""
    # end

end
