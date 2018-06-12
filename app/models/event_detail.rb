class EventDetail < ApplicationRecord
  belongs_to :event
  belongs_to :advisor
  default_scope { includes(:advisor).order('advisor.kana COLLATE "ja_JP.utf8" ASC') }
end
