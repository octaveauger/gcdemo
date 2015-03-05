class PaymentTemplate < ActiveRecord::Base
  belongs_to :merchant

  validates :nickname, presence: true
  validates :amount_gbp, presence: true
  validates :amount_eur, presence: true
  validates :charge_date, presence: true
end
