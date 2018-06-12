class Activity < ApplicationRecord
  belongs_to :event
  belongs_to :customer
  default_scope { includes(:customer).order('customer.kana COLLATE "ja_JP.utf8" ASC') }
end
