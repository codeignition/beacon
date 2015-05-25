class OdinClientController < ApplicationController
  def call_log
    @odin_client = CallLog.create! phone_number: params[:phone_number],answered_at: params[:answered_at],escalation_rule_key: params[:escalation_rule_key], level_number: params[:level_number],complaint_id: params[:complaint_id]
    @notify_complaint = ComplaintController.notify params[:complaint_id]
    render nothing: true
  end

  def odin_client_params
    params.require(:odin_client).permit(:phone_number, :answered_at, :escalation_rule_key, :level_number, :complaint_id)
  end

end
