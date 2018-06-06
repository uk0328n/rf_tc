class Advisor < ApplicationRecord
  has_many :event_details, dependent: :destroy
  has_many :events, through: :event_details
  default_scope -> { order(name: :asc) }
end
