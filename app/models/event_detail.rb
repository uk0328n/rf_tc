class EventDetail < ApplicationRecord
  belongs_to :event
  belongs_to :advisor
end
