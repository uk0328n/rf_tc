class Advisor < ApplicationRecord
  has_many :event_details, dependent: :destroy
  has_many :events, through: :event_details
  has_one :person
  default_scope { order('company COLLATE "ja_JP.utf8" ASC, kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { order('company ASC, kana ASC') } if Rails.env == 'development'

  def is_duplicated
    Customer.find_by(name: self.name, company: self.company).present?
  end
end
