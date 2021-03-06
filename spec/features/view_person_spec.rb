require 'rails_helper'

describe 'the person view', type: :feature do
  describe 'phone numbers' do
    describe 'email addresses' do

      let(:person) { Person.create(first_name: 'John', last_name: 'McLaughlin') }

      before(:each) do
        person.email_addresses.create(address: "Buckshot@email.com")
        person.email_addresses.create(address: "Le@email.com")
        person.email_addresses.create(address: "Funk@email.com")
        visit person_path(person)
      end

      before(:each) do
        person.phone_numbers.create(number: "555-1234")
        person.phone_numbers.create(number: "555-5678")
        visit person_path(person)
      end

      it 'shows the email address' do
        person.email_addresses.each do |email|
          expect(page).to have_selector('li', text: "Buckshot@email.com")
        end
      end

      it 'has a link to add an email address' do
        expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: person.id,
                                                     contact_type: "Person"))
      end

      it 'has a link to edit an email address' do
        person.email_addresses.each do |email|
          expect(page).to have_link('edit email', href: edit_email_address_path(email))
        end
      end

      it 'edits an email' do
        email = person.email_addresses.first
        old_email = email.address

        first(:link, 'edit email').click
        page.fill_in('Address', with: 'dude@dude.com')
        page.click_button('Update Email address')
        expect(current_path).to eq(person_path(person))
        expect(page).to have_content('dude@dude.com')
        expect(page).to_not have_content(old_email)
      end

      it 'has links to delete emails' do
        person.email_addresses.each do |email|
          expect(page).to have_link('delete email', href: email_address_path(email))
        end
      end

      it "deletes an email address" do
        email = person.email_addresses.first
        old_email = email.address

        first(:link, "delete email").click
        expect(current_path).to eq(person_path(person))
        expect(page).to_not have_content(old_email)
      end

      it 'adds a new email address' do
        page.click_link('Add email address')
        page.fill_in('Address', with: 'JohnnyMac@email.com')
        page.click_button('Create Email address')
        expect(current_path).to eq(person_path(person))
        expect(page).to have_content('JohnnyMac@email.com')
      end

      it 'shows the phone numbers' do
        person.phone_numbers.each do |phone|
          expect(page).to have_content(phone.number)
        end
      end

      it 'has a link to add a new phone number' do
        expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: person.id,
                                                                                  contact_type: "Person"))
      end

      it 'adds a new phone number' do
        page.click_link('Add phone number')
        page.fill_in('Number', with: '555-8888')
        page.click_button('Create Phone number')
        expect(current_path).to eq(person_path(person))
        expect(page).to have_content('555-8888')
      end

      it 'has links to edit phone numbers' do
        person.phone_numbers.each do |phone|
          expect(page).to have_link('edit', href: edit_phone_number_path(phone))
        end
      end

      it 'edits a phone number' do
        phone = person.phone_numbers.first
        old_number = phone.number

        first(:link, 'edit').click
        page.fill_in('Number', with: '555-9191')
        page.click_button('Update Phone number')
        expect(current_path).to eq(person_path(person))
        expect(page).to have_content('555-9191')
        expect(page).to_not have_content(old_number)
      end

      it 'has links to delete phone numbers' do
        person.phone_numbers.each do |phone|
          expect(page).to have_link('delete', href: phone_number_path(phone))
        end
      end

      it "deletes a phone number" do
        phone = person.phone_numbers.first
        deleted_number = phone.number

        first(:link, "delete").click
        expect(current_path).to eq(person_path(person))
        expect(page).to_not have_content(deleted_number)
      end
    end
  end
end