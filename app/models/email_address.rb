class EmailAddress < ActiveRecord::Base
  belongs_to :person

  validates :address, presence: true
  validates :persond_id, presence: true
end
