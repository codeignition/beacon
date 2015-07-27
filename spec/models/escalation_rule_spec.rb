require 'rails_helper'

RSpec.describe EscalationRule, :type => :model do
  it { should have_many(:levels) }

  context "uuid" do
    it "should create a new escalation rule with uuid in rule key" do
      organization = create :organization
      er_1 = EscalationRule.create(organization: organization,name: "foo")
      expect(er_1.rule_key).not_to eq nil
    end
    it "should test the uniqueness of uuid" do
      organization = create :organization
      er_2 = EscalationRule.create(organization: organization, name: "foo")
      er_1 = EscalationRule.create(organization: organization,name: "baar")
      expect(er_1.rule_key).not_to eq(er_2.rule_key)
    end
  end

  describe ':name validations' do
    it 'ensure presence of name for an escalation rule' do
      escalation_rule = EscalationRule.new
      expect{
        escalation_rule.save
      }.to change(EscalationRule, :count).by(0)
    end

    it 'ensure uniqueness of a name in an organization' do
      organization1 = Organization.create(name: "Organization")
      organization2 = Organization.create(name: "2nd Organization")
      escalation_rule1 = EscalationRule.new(name: "Datadog")
      escalation_rule1.organization_id = organization1.id
      escalation_rule1.save
      escalation_rule2 = EscalationRule.new(name: "Datadog")
      escalation_rule2.organization_id = organization1.id
      expect{
        escalation_rule2.save
      }.to change(EscalationRule, :count).by(0)
      escalation_rule3 = EscalationRule.new(name: "Datadog")
      escalation_rule3.organization_id = organization2.id
      expect{
        escalation_rule3.save
      }.to change(EscalationRule, :count).by(1)
    end
  end
end
