class CallUserController < ApplicationController
  def caller
    @escalation_rule = EscalationRule.find_by rule_key: params[:rule_key]
    if @escalation_rule.nil?
      head :bad_request
    elsif @escalation_rule.airplane_mode_in_progress?
      @complaint = ComplaintController.create_complaint @escalation_rule.id, @escalation_rule.organization_id, request.ip, params[:text]
      @complaint.status = "airplane_mode_on"
      @complaint.save
      render nothing: true
    else
      @complaint = ComplaintController.create_complaint @escalation_rule.id, @escalation_rule.organization_id, request.ip, params[:text]
      @level = @escalation_rule.levels.where(level_number: 1)
      @phone_numbers= Contact.find(@level.collect(&:contact_id)).collect(&:phone_number)
      result = OdinClient.call_user(@phone_numbers.uniq.join(","), params[:text],@escalation_rule.rule_key,@level.first.level_number,@complaint.id)
      if result
        render json: {complaint_id: @complaint.id, rule_key: @escalation_rule.rule_key}
      else
        head :not_found
      end
    end
  end

  def call_user_params
    params.require(:call_user).permit(:rule_key, :text)
  end
end
