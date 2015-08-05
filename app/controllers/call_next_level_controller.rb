class CallNextLevelController < ApplicationController
  def next_call
    @escalation_rule = EscalationRule.find_by rule_key: params[:escalation_rule_key]

    if @escalation_rule.blank?
      head :bad_request
    else
      @level = @escalation_rule.levels.where(level_number: (params[:level_number].to_i + 1))
      if @level.blank?
        complaint = Complaint.find(id: params[:complaint_id])
        complaint.status = 'failed'
        complaint.save
        head :bad_request
      else
        @phone_numbers= Contact.find(@level.collect(&:contact_id)).collect(&:phone_number)
        OdinClient.call_user(@phone_numbers.join(","), params[:text],@escalation_rule.rule_key,@level.first.level_number, params[:complaint_id] )

        render nothing: true
      end
    end
  end
  def call_next_level_params
    params.require(:call_user).permit( :text, :level_number, :escalation_rule_key, :complaint_id)
  end
end
