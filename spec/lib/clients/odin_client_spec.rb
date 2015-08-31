require 'rails_helper'

RSpec.describe OdinClient, :type => :model do
  context "call user" ,:vcr do
    it "should call user with given phone number" do
      complaint = Complaint.create 
      result = OdinClient.call_user("user/userd","boo yeahh","0abcb702e0c732a14ce5","1",complaint.id)
      expect(result).to eq true
    end

    xit 'sets the levels_called attribute of the respective complaint' do
    end
  end

  context 'terminate_pending_calls', :vcr do
    it 'sends the request to terminate pending calls to odin' do
      result = OdinClient.terminate_pending_calls('1234567890', 1)
      expect(result).to eq true
    end
  end
end
