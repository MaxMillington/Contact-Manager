class Person < ActiveRecord::Base
  has_many :phone_numbers
  has_many :email_addresses
  # belongs_to :company
  validates :first_name, :last_name, presence: true


end
