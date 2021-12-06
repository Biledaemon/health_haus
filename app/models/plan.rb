class Plan < ApplicationRecord
  monetize :price
  validates :price, presence: true
  validates :coverage_percent, presence: true
  validates :max_amount, presence: true
  validates :deductible, presence: true
end
