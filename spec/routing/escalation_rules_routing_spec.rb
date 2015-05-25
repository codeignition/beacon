require "rails_helper"

RSpec.describe EscalationRulesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/escalation_rules").to route_to("escalation_rules#index")
    end

    it "routes to #new" do
      expect(:get => "/escalation_rules/new").to route_to("escalation_rules#new")
    end

    it "routes to #show" do
      expect(:get => "/escalation_rules/1").to route_to("escalation_rules#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/escalation_rules/1/edit").to route_to("escalation_rules#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/escalation_rules").to route_to("escalation_rules#create")
    end

    it "routes to #update" do
      expect(:put => "/escalation_rules/1").to route_to("escalation_rules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/escalation_rules/1").to route_to("escalation_rules#destroy", :id => "1")
    end

  end
end
