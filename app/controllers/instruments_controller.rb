class InstrumentsController < ApplicationController

  def index
    @instruments = Instrument.all
  end

  def show
    @instrument = Instrument.find_by(id: params[:id])
  end

end
