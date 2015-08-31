require "rails_helper"

RSpec.describe ComplaintController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/alerts").to route_to("complaint#index")
    end

    it "routes to #resolve_complaint" do
      expect(:get => "/resolve").to route_to("complaint#resolve_complaint")
    end
  end
end
