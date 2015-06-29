require 'rails_helper'

RSpec.describe CallUserController, :type => :controller do

  let(:escalation_rule_valid_attributes){{
    :name => "sasasa",
    :organization =>(create :organization)
  }}


  let(:contact_valid_attributes){{
    :name => 'ruby',
    :phone_number => 'user/userd',
    :email_id => 'abc@gmail.com'
  }}

  let(:level_valid_attributes){{
    :escalation_rule_id => '1',
    :contact_id => '1',
    :level_number => '1'
  }}


  describe "GET caller ", :vcr do
    it "calls the user with the matching uuid" do
      escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
      escalation_rule.save
      contact = Contact.create! contact_valid_attributes
      contact.save
      level = Level.create! level_valid_attributes
      level.save
      expect(OdinClient).to receive(:call_user)
      get :caller, {:rule_key => escalation_rule.rule_key, :text => 'you know nothing jon snow'}
    end

    it "gets wrong uuid and gives error message" do
      escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
      escalation_rule.save
      contact = Contact.create! contact_valid_attributes
      contact.save
      level = Level.create! level_valid_attributes
      level.save
      response = get :caller, {:rule_key => '121212121', :text => 'you know nothing jon snow'}
      expect(response.status).to eq 400
    end

    describe 'when airplane mode is on' do
      it 'does not call user between start_time and end_time' do
        escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
        escalation_rule.airplane_mode_on = true
        escalation_rule.airplane_mode_start_time = (Time.now-3600).seconds_since_midnight
        escalation_rule.airplane_mode_end_time = (Time.now+3600).seconds_since_midnight
        escalation_rule.save
        contact = Contact.create! contact_valid_attributes
        contact.save
        level = Level.create! level_valid_attributes
        level.save
        expect(OdinClient).to_not receive(:call_user)
        get :caller, {:rule_key => escalation_rule.rule_key, :text => 'jon snow is dead'}
      end

      it 'adds a complain with status "airplane mode on" between start_time and end_time' do
        escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
        escalation_rule.airplane_mode_on = true
        escalation_rule.airplane_mode_start_time = (Time.now-3600).seconds_since_midnight
        escalation_rule.airplane_mode_end_time = (Time.now+3600).seconds_since_midnight
        escalation_rule.save
        contact = Contact.create! contact_valid_attributes
        contact.save
        level = Level.create! level_valid_attributes
        level.save
        get :caller, {:rule_key => escalation_rule.rule_key, :text => 'jon snow is dead'}
        expect(assigns(:complaint)).to be_a(Complaint)
        expect(assigns(:complaint).status).to eq("Airplane Mode ON")
      end

      it 'calls user before start_time and after end_time' do
        escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
        escalation_rule.airplane_mode_on = true
        escalation_rule.airplane_mode_start_time = Time.now+3600
        escalation_rule.airplane_mode_end_time = Time.now+4800
        contact = Contact.create! contact_valid_attributes
        contact.save
        level = Level.create! level_valid_attributes
        level.save
        expect(OdinClient).to receive(:call_user)
        get :caller, {:rule_key => escalation_rule.rule_key, :text => 'jon snow is dead'}
      end

    end
  end
end
