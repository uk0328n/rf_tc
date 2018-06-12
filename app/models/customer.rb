class Customer < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :events, through: :activities
  default_scope { order('kana COLLATE "ja_JP.utf8" ASC') }
end
