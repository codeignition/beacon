require 'rails_helper'
RSpec.describe Contact, :type => :model do

it { should have_many(:levels) }
it { should belong_to(:user) }

  describe 'unverified?' do
    it 'returns true if a Contact is verified' do
      user = User.create(email: "example@example.com")
      contact = user.contacts.create(name: "Hari", email_id: "example@example.com", phone_number: "09999999999")
      contact.confirmed_at = Time.now
      contact.save
      expect(contact.unverified?).to eq(false)
    end

    it 'returns false if a contact is unverified' do
      user = User.create(email: "example@example.com")
      contact = user.contacts.create(name: "Hari", email_id: "example@example.com", phone_number: "09999999999")
      expect(contact.unverified?).to eq(true)
    end
  end
end
