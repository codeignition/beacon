class ComplaintController < ApplicationController
  def index
    if current_org.contacts.empty?
      redirect_to setup_1_path
    end
    offset = (params[:page] || 0 ) * 20
    @complaints = Complaint.where(escalation_rule: EscalationRule.where(organization: current_org)).preload(:call_log).order(id: :desc).limit(20).offset(offset)
  end

  def resolve_complaint
    @complaint = Complaint.find_by(id: params[:complaint_id])
    if @complaint.nil?
      return head :bad_request
    else
      if @complaint.status == 'pending'
        levels = Level.where("level_number >= ? AND escalation_rule_id = ?", @complaint.levels_called, @complaint.escalation_rule_id)
        phone_numbers= Contact.find(levels.collect(&:contact_id)).collect(&:phone_number)
        @complaint.status = 'resolve status request in progress'
        @complaint.save
        result = OdinClient.terminate_pending_calls phone_numbers.uniq.join(","), @complaint.id
        if result
          @complaint.status = 'resolved'
          @complaint.save
          return render nothing: true
        else
          @complaint.status = 'resolve status request failed'
          @complaint.save
          return head :not_found
        end
      else
        @complaint.status = 'resolved'
        @complaint.save
        return render nothing: true
      end
    end
    render nothing: true
  end

  class << self
    def create_complaint escalation_rule_id, organization_id, ip_address
      @complaint =  Complaint.create! status: "pending" , escalation_rule_id: escalation_rule_id, organization_id: organization_id, ip_address: ip_address
    end

    def notify complaint_id
      @complaint = Complaint.find_by id: complaint_id
      @complaint.status = "notified"
      @complaint.save
    end
  end
end
