class Advisor < ApplicationRecord
  has_many :event_details, dependent: :destroy
  has_many :events, through: :event_details
  default_scope { order('company COLLATE "ja_JP.utf8" ASC, kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { order('company ASC, kana ASC') } if Rails.env == 'development'
end
