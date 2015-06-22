class OdinClientController < ApplicationController
  def call_log
    call_log_params = params[:call_log]
    @odin_client = CallLog.create! phone_number: call_log_params[:phone_number],answered_at: call_log_params[:answered_at],escalation_rule_key: call_log_params[:escalation_rule_key], level_number: call_log_params[:level_number],complaint_id: call_log_params[:complaint_id]
    @notify_complaint = ComplaintController.notify call_log_params[:complaint_id]
    render nothing: true
  end

  def verify_contact
    contact = Contact.where(phone_number: "0#{params[:phone_number]}").first
    contact.confirm if  !contact.nil? and contact.unverified?
    render nothing: true
  end

end
