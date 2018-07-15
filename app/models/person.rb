class Person < ApplicationRecord
  belongs_to :company
  has_many :activities, dependent: :destroy
  has_many :events, through: :activities
  default_scope { includes(:company).order('companies.short_name_kana COLLATE "ja_JP.utf8" ASC, people.kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { includes(:company).order('companies.short_name_kana ASC, people.kana ASC') } if Rails.env == 'development'
end
