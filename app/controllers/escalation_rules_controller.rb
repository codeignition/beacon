class EscalationRulesController < ApplicationController
  before_action :set_escalation_rule, only: [:show, :edit, :update, :destroy]

  # GET /escalation_rules
  # GET /escalation_rules.json
  def index
    @escalation_rules = current_user.escalation_rules
  end

  # GET /escalation_rules/1
  # GET /escalation_rules/1.json
  def show
  end

  # GET /escalation_rules/new
  def new
    @escalation_rule = EscalationRule.new
  end

  # GET /escalation_rules/1/edit
  def edit
  end

  # POST /escalation_rules
  # POST /escalation_rules.json
  def create
    @escalation_rule = current_org.escalation_rules.new(escalation_rule_params)
    params[:escalation_rule][:contacts].each do |i, contact|
      if Contact.find(contact['id']).unverified?
        return respond_to do |format|
          format.html { render :new }
          format.json { render json: {message: "Contacts should be verified", status: :unprocessable_entity} }
        end
      end
      Level.create(escalation_rule: @escalation_rule, contact_id: contact['id'], level_number: contact['level'])
    end
    respond_to do |format|
      if @escalation_rule.save
        format.html { redirect_to @escalation_rule, notice: 'Escalation rule was successfully created.' }
        format.json { render :show, status: :created, location: @escalation_rule }
      else
        format.html { render :new }
        format.json { render json: { errors: @escalation_rule.errors.full_messages, status: :unprocessable_entity } }
      end
    end
  end

  # PATCH/PUT /escalation_rules/1
  # PATCH/PUT /escalation_rules/1.json
  def update
    respond_to do |format|
      if @escalation_rule.update(escalation_rule_params)
        @escalation_rule.levels.each {|level| level.destroy}
        params[:escalation_rule][:contacts].each do |i, contact|
          Level.create(escalation_rule: @escalation_rule, contact_id: contact['id'], level_number: contact['level'])
        end
        format.html { redirect_to @escalation_rule, notice: 'Escalation rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @escalation_rule }
      else
        format.html { render :edit }
        format.json { render json: @escalation_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /escalation_rules/1
  # DELETE /escalation_rules/1.json
  def destroy
    @escalation_rule.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Escalation rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_escalation_rule

    @escalation_rule = EscalationRule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def escalation_rule_params
    params.require(:escalation_rule).permit(:name, :airplane_mode_on, :airplane_mode_start_time, :airplane_mode_end_time)
  end
end
