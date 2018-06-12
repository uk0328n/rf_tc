class EventDetail < ApplicationRecord
  belongs_to :event
  belongs_to :advisor
  default_scope { includes(:advisor).order('advisors.kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { includes(:advisor).order('advisors.kana ASC') } if Rails.env == 'development'
end
