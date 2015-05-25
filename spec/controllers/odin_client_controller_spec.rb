require 'rails_helper'

RSpec.describe OdinClientController, :type => :controller do

  let(:valid_attributes){
    {:phone_number => "9999999999",
     :answered_at =>"2014-07-07 10:50:19 +0530",
     :escalation_rule_key => "0abcb702e0c732a14ce5",
     :level_number => "1"
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
end
