require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do
  let(:person) { Person.create(:first_name => "Jimmy", :last_name => "Smith") }
  let(:phone_number) { PhoneNumber.new(number: '1112223333', contact_id: person.id,
                                       contact_type: 'Person') }

  it 'is valid' do
    expect(phone_number).to be_valid
  end

  it 'is invalid without a number' do
    phone_number.number = nil
    expect(phone_number).to_not be_valid
  end

  it 'must have reference to a contact' do
    phone_number.contact_id = nil
    expect(phone_number).not_to be_valid
  end

  it 'is associated with a person' do
    expect(phone_number).to respond_to(:contact)
  end

  # it 'must have reference to a company' do
  #   phone_number.company_id = nil
  #   expect(phone_number).not_to be_valid
  # end
  #
  # it 'is associated with a company' do
  #   expect(phone_number).to respond_to(:company)
  # end

end
