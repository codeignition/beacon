class Complaint < ActiveRecord::Base
belongs_to :escalation_rule
has_one :call_log
belongs_to :organization

end
