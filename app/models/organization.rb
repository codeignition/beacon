class Organization < ActiveRecord::Base
	has_many :organization_users
	has_many :users, through: :organization_users
  has_many :contacts
  has_many :escalation_rules
  before_validation :defaults

  def defaults 
    self.token = SecureRandom.hex.to_s
    self.name = self.name.upcase if self.name
  end

end
