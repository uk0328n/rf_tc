class Person < ApplicationRecord
  has_one :customer
  has_one :advisor
end