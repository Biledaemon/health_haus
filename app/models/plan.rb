class Plan < ApplicationRecord
  validates :price, presence: true
end
