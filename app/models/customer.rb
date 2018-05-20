class Customer < ApplicationRecord
  has_many :activities
  has_many :events, through: :activities
end
