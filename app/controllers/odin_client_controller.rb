class OdinClientController < ApplicationController
  def call_log
    answered_at = DateTime.strptime(call_log_params[:answered_at])
    answered_at = answered_at.in_time_zone('New Delhi')
    @odin_client = CallLog.create! phone_number: call_log_params[:phone_number],answered_at: answered_at,escalation_rule_key: call_log_params[:escalation_rule_key], level_number: call_log_params[:level_number],complaint_id: call_log_params[:complaint_id]
    @notify_complaint = ComplaintController.notify call_log_params[:complaint_id]
    render nothing: true
  end

  def verify_contact
    contact = Contact.where(phone_number: "0#{params[:phone_number]}").first
    contact.confirm if  !contact.nil? and contact.unverified?
    render nothing: true
  end

  def call_log_params
    params.permit(:phone_number, :answered_at, :escalation_rule_key, :level_number, :complaint_id)
  end
end
