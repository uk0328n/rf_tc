class Customer < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :events, through: :activities
  default_scope { order('company COLLATE "ja_JP.utf8" ASC, kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { order('company ASC, kana ASC') } if Rails.env == 'development'
end
