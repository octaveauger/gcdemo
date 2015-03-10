class PaymentTemplate < ActiveRecord::Base
  belongs_to :merchant

  validates :nickname, presence: true
  validates :amount_gbp, presence: true
  validates :amount_eur, presence: true
  validates :charge_date, presence: true, numericality: { only_integer: true }
  validates_inclusion_of :charge_date, in: (10..1000).to_a.unshift(0)
end
