class SubscriptionTemplate < ActiveRecord::Base
  belongs_to :merchant

  validates :name, presence: true
  validates :amount_gbp, presence: true
  validates :amount_eur, presence: true
  validates :day_of_month, presence: true
  validates_inclusion_of :day_of_month, in: (1..28).to_a.unshift(-1)
  validates :interval_unit, presence: true
  validates_inclusion_of :interval_unit, in: %w( weekly monthly yearly )
  validates :interval, presence: true
end
