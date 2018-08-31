class Company < ApplicationRecord
  has_many :people
  has_many :activities, through: :people
  default_scope { order('short_name_kana COLLATE "ja_JP.utf8" ASC') } if Rails.env == 'production'
  default_scope { order('short_name_kana ASC') } if Rails.env == 'development'

  before_validation :set_short_name

  def set_short_name
    if self.short_name.blank?
      self.short_name = self.name
    end
    if self.short_name_kana.blank?
      self.short_name_kana = self.kana
    end
  end
end
