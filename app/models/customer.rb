class Customer < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :events, through: :activities
  default_scope -> { order(name: :asc) }
end
