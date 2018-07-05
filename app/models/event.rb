class Event < ApplicationRecord
  has_many :activities, dependent: :destroy
  accepts_nested_attributes_for :activities, allow_destroy: true
  has_many :people, through: :activities
  validates :name, :event_date, :venue, :capacity, presence: true
end
