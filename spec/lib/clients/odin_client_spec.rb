require 'rails_helper'

RSpec.describe OdinClient, :type => :model do
  context "call user" ,:vcr do
    it "should call user with given phone number" do
      response = OdinClient.call_user("user/userd","boo yeahh","0abcb702e0c732a14ce5","1",1)
      expect(response.status).to eq 200
    end
  end
end
