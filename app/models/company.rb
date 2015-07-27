class Company < ActiveRecord::Base
  has_many :phone_numbers
  # has_many :people
  has_many :email_addresses

  validates :name, presence: true
end
