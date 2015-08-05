class OdinClientController < ApplicationController
  def call_log
    @odin_client = CallLog.create! call_log_params
    @notify_complaint = ComplaintController.notify call_log_params[:complaint_id]
    render nothing: true
  end

  def verify_contact
    contact = Contact.where(phone_number: "0#{params[:phone_number]}").first
    contact.confirm if  !contact.nil? and contact.unverified?
    render nothing: true
  end

  def call_log_params
    params.require(:call_log).permit(:phone_number, :answered_at, :escalation_rule_key, :level_number, :complaint_id)
  end
end
