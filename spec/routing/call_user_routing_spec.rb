require "rails_helper"

RSpec.describe CallUserController, :type => :routing do
  describe "routing" do

    it "routes to #caller" do
      expect(:get => "/call").to route_to("call_user#caller")
    end
  end
end
