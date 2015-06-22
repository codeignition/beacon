require 'rails_helper'

RSpec.describe OdinClientController, :type => :controller do
  let (:complaint){create :complaint}

  let(:valid_attributes){
    {:phone_number => "9999999999",
     :answered_at =>"2014-07-07 10:50:19 +0530",
     :escalation_rule_key => "0abcb702e0c732a14ce5",
     :level_number => "1",
     :complaint_id => complaint.id
  }}

  let(:valid_session){{
  }}

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CallLog" do
        expect {
          post :call_log, {:call_log => valid_attributes}, valid_session
        }.to change(CallLog, :count).by(1)
      end
    end
  end

  context "POST verify phonenumber" do
    it "should verify the given contact number" do
      contact = create :contact
      expect(contact.confirmed_at).to be_nil
      post :verify_contact, {:phone_number => contact.phone_number}, valid_session
      contact.reload
      expect(contact.confirmed_at).to_not be_nil
      expect(response.status).to eq 200
    end

     it "should handle nil case" do
      post :verify_contact, {:phone_number => "111111"}, valid_session

      expect(response.status).to eq 200
    end

  end
end
