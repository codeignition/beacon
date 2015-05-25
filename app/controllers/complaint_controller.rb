class ComplaintController < ApplicationController
    def index
      if current_org.contacts.empty?
        redirect_to setup_1_path
      end
      offset = (params[:page] || 0 ) * 20
      @complaints = Complaint.where(escalation_rule: EscalationRule.where(organization: current_org)).preload(:call_log).order(id: :desc).limit(20).offset(offset)
    end
  class << self
    def create_complaint escalation_rule_id,user_id, ip_address
      @complaint =  Complaint.create! status: "pending" , escalation_rule_id: escalation_rule_id, user_id: user_id, ip_address: ip_address
    end

    def notify complaint_id
      @complaint = Complaint.find_by id: complaint_id
      @complaint.status = "notified"
      @complaint.save
    end

  end
end
