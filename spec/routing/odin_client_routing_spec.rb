require "rails_helper"

RSpec.describe OdinClientController, :type => :routing do
  describe "routing" do

    it "routes to #call_log" do
      expect(:post => "/calllog").to route_to("odin_client#call_log")
    end

    it "routes to #verify_contact" do
      expect(:post => "/verify").to route_to("odin_client#verify_contact")
    end
  end
end
