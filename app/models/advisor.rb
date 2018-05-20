class Advisor < ApplicationRecord
  has_many :event_details
  has_many :events, through: :event_details
end
