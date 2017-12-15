class Trader < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :github]

  has_many :comments
  has_many :commented_trades, through: :comments, class_name: "Trade"
  has_many :trades
  has_many :instruments, through: :trades

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |trader|
      trader.provider = auth.provider
      trader.uid = auth.uid
      trader.name = auth.info.name
      trader.email = auth.info.email
      trader.password = Devise.friendly_token[0,20]
    end
  end

end
