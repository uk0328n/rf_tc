class Customer < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :events, through: :activities
  default_scope { order('kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { order('kana ASC') } if Rails.env == 'development'
end
