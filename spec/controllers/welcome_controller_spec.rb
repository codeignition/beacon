require 'rails_helper'

describe WelcomeController do

  login_user

  let(:valid_attributes_contacts){
    {:name =>"Sartaj",
     :phone_number => "9999999999",
     :email_id => "sa@email.com"
  }}

  let(:organization){create :organization}

  it "should have a current_user" do
    expect(subject.current_user).to_not be nil
  end

  it "should get result" do
    get 'result'
    expect(response.code).to eq "200"
  end

  describe "GET result" do
    it 'redirects to alert page if current user is not admin of current org' do
      user = User.create(email: 'another@example.com')
      organization = Organization.create(name: 'Another Organization')
      org_user = OrganizationUser.new(user: user, organization: organization, is_admin: true)
      org_user.save
      subject.current_org=(organization.id)
      get :result
      expect(response).to redirect_to('/alerts')
    end

    it "should assign current user's contacts and escalation_rules to the variables " do
      escalation_rule1 = EscalationRule.new(name: "rule", organization: organization)
      escalation_rule1.save
      escalation_rule = EscalationRule.create(name: "rule", organization: subject.current_org)
      contact = Contact.create valid_attributes_contacts
      contact.organization = subject.current_org
      contact.save
      get :result
      expect(assigns(:escalation_rules)).to eq([escalation_rule])
      expect(assigns(:contacts)).to eq([contact])
      expect(response.status).to eq(200)
    end

  end
end
