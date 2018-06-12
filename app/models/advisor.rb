class Advisor < ApplicationRecord
  has_many :event_details, dependent: :destroy
  has_many :events, through: :event_details
  default_scope { order('kana COLLATE "ja_JP.utf8" ASC') }
end
