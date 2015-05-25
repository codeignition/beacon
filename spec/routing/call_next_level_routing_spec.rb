require "rails_helper"

RSpec.describe CallNextLevelController, :type => :routing do
  describe "routing" do

    it "routes to #next_call" do
      expect(:get => "/nextcall").to route_to("call_next_level#next_call")
    end
  end
end
