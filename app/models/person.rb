class Person < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :events, through: :activities
  default_scope { order('company_kana COLLATE "ja_JP.utf8" ASC, company_short_name COLLATE "ja_JP.utf8" ASC, kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { order('company_kana ASC, company_short_name ASC, kana ASC') } if Rails.env == 'development'
end
