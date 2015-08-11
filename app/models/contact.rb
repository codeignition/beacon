class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :levels
  belongs_to :organization
  validates :name, presence: true
  validates :email_id, presence: true
  validates :phone_number, presence: true

  before_destroy { |record| Level.destroy_all "contact_id = #{record.id}"   }
  def unverified?
    Contact.where(phone_number: self.phone_number).order(confirmed_at: :desc).first.confirmed_at ? false : true
  end

  def confirm
    Contact.where(phone_number: self.phone_number, confirmed_at: nil).update_all(confirmed_at: Time.now)
  end

  def self.at_least_one_contact_verified? contacts
    contacts.each do |contact|
      if !contact.unverified?
        return true
      end
    end
    return false
  end
end
