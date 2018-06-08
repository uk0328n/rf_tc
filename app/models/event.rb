class Event < ApplicationRecord
  has_many :event_details, dependent: :destroy
  has_many :activities, dependent: :destroy
  accepts_nested_attributes_for :event_details, allow_destroy: true
  accepts_nested_attributes_for :activities, allow_destroy: true
  has_many :customers, through: :activities
  has_many :advisors, through: :event_details
  validates :name, :event_date, :venue, :capacity, presence: true
end
