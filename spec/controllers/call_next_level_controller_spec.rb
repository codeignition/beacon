require 'rails_helper'

RSpec.describe CallNextLevelController, :type => :controller do

  let(:escalation_rule_valid_attributes){{
    :name => "sasasa",
    :organization =>(create :organization)
  }}

  let(:contact_valid_attributes){{
    :name => 'ruby',
    :phone_number => 'user/userd',
    :email_id => 'abc@gmail.com'
  }}

  let(:contact_valid_attributes_two){{
    :name => 'hen',
    :phone_number => 'user/userc',
    :email_id => 'hen@gmail.com'
  }}

  let(:level_valid_attributes){{
    :escalation_rule_id => '1',
    :contact_id => '1',
    :level_number => '1'
  }}

  let(:level_valid_attributes_two){{
    :escalation_rule_id => '1',
    :contact_id => '2',
    :level_number => '2'
  }}
  let(:level_invalid_attributes){{
    :escalation_rule_id => '1',
    :contact_id => '1',
    :level_number => nil
  }}
  describe "GET next caller ", :vcr do
    it "calls the next user with the matching uuid" do
      escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
      escalation_rule.save
      contact = Contact.create! contact_valid_attributes
      contact.save
      contact_two = Contact.create! contact_valid_attributes_two
      contact_two.save
      level = Level.create! level_valid_attributes
      level.save
      level_two = Level.create! level_valid_attributes_two
      level_two.save
      expect(OdinClient).to receive(:call_user)
      get :next_call, {:escalation_rule_key => escalation_rule.rule_key, :text => 'you know nothing jon snow', :level_number => level.level_number}
    end
    it "gets wrong uuid and gives error message" do
      escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
      escalation_rule.save
      contact = Contact.create! contact_valid_attributes
      contact.save
      level = Level.create! level_valid_attributes
      level.save
      response = get :next_call, {:rule_key => '121212121', :text => 'you know nothing jon snow'}
      expect(response.status).to eq 400
    end

    it "gets invalid level number and gives error message" do
      escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
      escalation_rule.save
      contact = Contact.create! contact_valid_attributes
      contact.save
      level = Level.create! level_invalid_attributes
      level.save
      response = get :next_call, {:rule_key => escalation_rule.rule_key, :text => 'you know nothing jon snow'}
      expect(response.status).to eq 400
    end
  end
end
