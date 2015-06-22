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
      expect(OdinClient).to receive(:call_user).with(contact_valid_attributes[:phone_number],'you know nothing jon snow', escalation_rule.rule_key,level.level_number)
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

  end
end
