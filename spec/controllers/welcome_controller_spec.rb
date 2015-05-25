require 'rails_helper'

describe WelcomeController do

  login_user

  let(:valid_attributes_contacts){
    {:name =>"Sartaj",
     :phone_number => "9999999999",
     :email_id => "sa@email.com"
  }}


  let(:valid_attributes_escalation) {
    {:name=>"Akash"}
  }

  it "should have a current_user" do
    expect(subject.current_user).to_not be nil
  end

  it "should get result" do
    get 'result'
    expect(response.code).to eq "200"
  end
  describe "GET result" do
    it "should assign current user's contacts and escalation_rules to the variables " do
      contact =Contact.create! valid_attributes_contacts
      contact.user=subject.current_user
      contact.save

      escalation_rule = EscalationRule.create! valid_attributes_escalation
      escalation_rule.user=subject.current_user
      escalation_rule.save
      get :result
      expect(assigns(:escalation_rules)).to eq([escalation_rule])
      expect(assigns(:contacts)).to eq([contact])
    end

  end
end
