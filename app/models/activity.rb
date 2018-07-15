class Activity < ApplicationRecord
  belongs_to :event
  belongs_to :person
  has_one :company, through: :person
  default_scope { includes(:person).includes(:company).order('companies.short_name_kana COLLATE "ja_JP.utf8" ASC, people.kana COLLATE "ja_JP.utf8" ASC').references(:company) } if Rails.env == 'production'
  default_scope { includes(:person).includes(:company).order('companies.short_name_kana ASC, people.kana ASC').references(:company) } if Rails.env == 'development'
end
