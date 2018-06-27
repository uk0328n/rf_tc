class Customer < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :events, through: :activities
  has_one :person
  default_scope { order('company COLLATE "ja_JP.utf8" ASC, kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { order('company ASC, kana ASC') } if Rails.env == 'development'

  def is_duplicated
    Advisor.find_by(name: self.name, company: self.company).present?
  end
end
