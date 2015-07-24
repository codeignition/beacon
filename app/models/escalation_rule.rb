class EscalationRule < ActiveRecord::Base
  belongs_to :organization
  has_many :levels
  has_many :complaints
  validates :name, presence: true

  before_save :create_rule_key

  def create_rule_key
    self.rule_key= self.organization.token + '/' +  self.name.gsub(' ', '_').underscore.downcase
  end

  def queue_one_members
    self.levels.where(level_number: 1).map(&:contact)
  end

  def rule_contacts
  	levels = {}
  	self.levels.each do |level|
      if levels[level.level_number]
         levels[level.level_number] << level.contact
      else
         levels[level.level_number] = [level.contact] 
      end
  	end
  	levels
  end

  def contact_present? contact
    present=false
    self.rule_contacts.each_value do |value|
      if value.include? contact
        present = true
      end
    end
    present
  end
end
