class Activity < ApplicationRecord
  belongs_to :event
  belongs_to :person
  default_scope { includes(:person).order('people.company_kana COLLATE "ja_JP.utf8" ASC, people.company_short_name COLLATE "ja_JP.utf8" ASC, people.kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { includes(:person).order('people.company_kana ASC, people.company_short_name ASC, people.kana ASC') } if Rails.env == 'development'
end
