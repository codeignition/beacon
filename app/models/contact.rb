class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :levels
  belongs_to :organization
  validates :name, presence: true
  validates :email_id, presence: true
  validates :phone_number, presence: true

  before_destroy { |record| Level.destroy_all "contact_id = #{record.id}"   }
  def unverified?
    id = User.where(email: self.email_id).first.id
    Contact.where(user: id).order(confirmed_at: :desc).last.confirmed_at ? false : true
  end

  def confirm
    self.confirmed_at = Time.now
    self.save!
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
