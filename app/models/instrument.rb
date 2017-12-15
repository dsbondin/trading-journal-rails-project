class Instrument < ApplicationRecord
  has_many :trades
  has_many :traders, through: :trades
end
