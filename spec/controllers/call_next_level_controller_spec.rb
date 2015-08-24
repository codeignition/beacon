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
  describe "GET next_call ", :vcr do
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

    describe 'when there are no more contacts to call' do
      it 'sets complaint status to "failed"' do
        user = User.create(email: 'person1@example.com')
        user.contacts.create(name: 'admin', email_id: user.email, phone_number: '01234567890')
        escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
        escalation_rule.save
        org_user = OrganizationUser.new(user: user, organization: escalation_rule.organization, is_admin: true)
        org_user.save
        contact = Contact.create! contact_valid_attributes
        contact.save
        level = Level.create! level_valid_attributes
        level.save
        complaint = Complaint.create(escalation_rule_id: escalation_rule)
        expect(OdinClient).to_not receive(:call_user)
        get :next_call, {:escalation_rule_key => escalation_rule.rule_key, :text => 'you know nothing jon snow', :level_number => level.level_number, complaint_id: complaint.id}
        complaint.reload
        expect(complaint.status).to eq('failed')
      end

      it 'does not call user' do
        user = User.create(email: 'person1@example.com')
        user.contacts.create(name: 'admin', email_id: user.email, phone_number: '01234567890')
        escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
        escalation_rule.save
        org_user = OrganizationUser.new(user: user, organization: escalation_rule.organization, is_admin: true)
        org_user.save
        contact = Contact.create! contact_valid_attributes
        contact.save
        level = Level.create! level_valid_attributes
        level.save
        complaint = Complaint.create(escalation_rule_id: escalation_rule)
        expect(OdinClient).to_not receive(:call_user)
        get :next_call, {:escalation_rule_key => escalation_rule.rule_key, :text => 'you know nothing jon snow', :level_number => level.level_number, complaint_id: complaint.id}
      end

      it 'sends a mail to admin about the incident' do
        user = User.create(email: 'person1@example.com')
        user.contacts.create(name: 'admin', email_id: user.email, phone_number: '01234567890')
        escalation_rule = EscalationRule.create! escalation_rule_valid_attributes
        escalation_rule.save
        org_user = OrganizationUser.new(user: user, organization: escalation_rule.organization, is_admin: true)
        org_user.save
        contact = Contact.create! contact_valid_attributes
        contact.save
        level = Level.create! level_valid_attributes
        level.save
        complaint = Complaint.create(escalation_rule_id: escalation_rule)
        expect {
        get :next_call, {
          :escalation_rule_key => escalation_rule.rule_key, :text => 'you know nothing jon snow', :level_number => level.level_number, complaint_id: complaint.id}
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
