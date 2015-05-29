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
end
