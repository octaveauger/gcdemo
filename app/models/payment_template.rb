class PaymentTemplate < ActiveRecord::Base
  belongs_to :merchant

  validates :nickname, presence: true
  validates :amount_gbp, presence: true
  validates :amount_eur, presence: true
  validates :charge_date, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10 }
end
