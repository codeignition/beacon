class CallUserController < ApplicationController
  def caller
    @escalation_rule = EscalationRule.find_by rule_key: params[:rule_key]
    if @escalation_rule.nil?
      head :bad_request
    elsif @escalation_rule.airplane_mode_on && (@escalation_rule.airplane_mode_start_time <= Time.now) && (Time.now <= @escalation_rule.airplane_mode_end_time)
      @complaint = ComplaintController.create_complaint @escalation_rule.id, @escalation_rule.organization_id, request.ip
      @complaint.status = "Airplane Mode ON"
      render nothing: true
    else
      @complaint = ComplaintController.create_complaint @escalation_rule.id, @escalation_rule.organization_id, request.ip
      @level = @escalation_rule.levels.where(level_number: 1)
      @phone_numbers= Contact.find(@level.collect(&:contact_id)).collect(&:phone_number)
      OdinClient.call_user(@phone_numbers.join(","), params[:text],@escalation_rule.rule_key,@level.first.level_number,@complaint.id)
      render nothing: true
    end
  end

  def call_user_params
    params.require(:call_user).permit(:rule_key, :text)
  end
end
