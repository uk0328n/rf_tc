class Activity < ApplicationRecord
  belongs_to :event
  belongs_to :customer
  default_scope { includes(:customer).order('customers.kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { includes(:customer).order('customers.kana ASC') } if Rails.env == 'development'
end
