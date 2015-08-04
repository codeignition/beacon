require 'rails_helper'
RSpec.describe Contact, :type => :model do

it { should have_many(:levels) }
it { should belong_to(:user) }

  describe 'unverified?' do
    it 'returns false if a Contact is verified' do
      user = User.create(email: "example@example.com")
      contact = user.contacts.create(name: "Hari", email_id: "example@example.com", phone_number: "09999999999")
      contact.confirmed_at = Time.now
      contact.save
      expect(contact.unverified?).to eq(false)
    end

    it 'returns true if a contact is unverified' do
      user = User.create(email: "example@example.com")
      contact = user.contacts.create(name: "Hari", email_id: "example@example.com", phone_number: "09999999999")
      expect(contact.unverified?).to eq(true)
    end
  end

  describe 'at_least_one_contact_verified?' do
    it 'returns true if at least one contact is verified' do
      user1 = User.create(email: "example1@example.com")
      user2 = User.create(email: "example2@example.com")
      contacts =[]
      contact1 = user1.contacts.create(name: "h", email_id: user1.email, phone_number: "09999999999")
      contact2 = user2.contacts.create(name: "ho", email_id: user2.email, phone_number: "09999999990")
      contact2.confirmed_at = Time.now
      contact2.save
      contacts.push contact1
      contacts.push contact2
      expect(Contact.at_least_one_contact_verified? contacts).to eq(true)
    end

    it 'returns false if not a single contact is verified' do
      user1 = User.create(email: "example1@example.com")
      user2 = User.create(email: "example2@example.com")
      contacts =[]
      contact1 = user1.contacts.create(name: "h", email_id: user1.email, phone_number: "09999999999")
      contact2 = user2.contacts.create(name: "ho", email_id: user2.email, phone_number: "09999999990")
      contacts.push contact1
      contacts.push contact2
      expect(Contact.at_least_one_contact_verified? contacts).to eq(false)
    end
  end
end
