class Trade < ApplicationRecord
  belongs_to :trader
  belongs_to :instrument
  has_many :comments
  accepts_nested_attributes_for :instrument

  def name
    "#{direction.capitalize} #{instrument.symbol}"
  end

  def instrument_attributes=(symbol)
    self.instrument = Instrument.find_or_create_by(symbol)
  end

  def profit_loss
    direction == "long" ? ((exit - entry) * quantity) : ((entry - exit) * quantity)
  end

end
