class Level < ActiveRecord::Base
  belongs_to :escalation_rule
  belongs_to :contact
end
