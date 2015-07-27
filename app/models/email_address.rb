class EmailAddress < ActiveRecord::Base
  belongs_to :person
  belongs_to :company

  validates :address, presence: true
  validates :person_id, presence: true
end
