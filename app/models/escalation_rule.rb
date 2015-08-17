class EscalationRule < ActiveRecord::Base
  belongs_to :organization
  has_many :levels
  has_many :complaints
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :organization_id

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

  def airplane_mode_in_progress?
    timestamp = Time.now
    if self.airplane_mode_on
      if self.weekend_airplane_mode_on
        if (timestamp.wday == 0 or timestamp.wday == 6) and (timestamp.seconds_since_midnight >= self.weekend_airplane_mode_start_time and timestamp.seconds_since_midnight <= self.weekend_airplane_mode_end_time)
          return true
        end
      elsif self.weekday_airplane_mode_on
        if (timestamp.wday > 0 and timestamp.wday < 6) and (timestamp.seconds_since_midnight >= self.weekday_airplane_mode_start_time and timestamp.seconds_since_midnight <= self.weekday_airplane_mode_end_time)
          return true
        end
      end
    end
    return false
  end
end
