require 'rails_helper'


RSpec.describe EscalationRulesController, :type => :controller do
  login_user

  let(:valid_attributes) {
    {:name=>"Akash"}
  }

  let(:invalid_attributes) {
    {:name=>nil}
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all escalation_rules as @escalation_rules" do
      escalation_rule = EscalationRule.create! valid_attributes
      escalation_rule.user=subject.current_user
      escalation_rule.save
      get :index, {}, valid_session
      expect(assigns(:escalation_rules)).to eq([escalation_rule])
    end
  end

  describe "GET show" do
    it "assigns the requested escalation_rule as @escalation_rule" do
      escalation_rule = EscalationRule.create! valid_attributes
      get :show, {:id => escalation_rule.to_param}, valid_session
      expect(assigns(:escalation_rule)).to eq(escalation_rule)
    end
  end

  describe "GET new" do
    it "assigns a new escalation_rule as @escalation_rule" do
      get :new, {}, valid_session
      expect(assigns(:escalation_rule)).to be_a_new(EscalationRule)
    end
  end

  describe "GET edit" do
    it "assigns the requested escalation_rule as @escalation_rule" do
      escalation_rule = EscalationRule.create! valid_attributes
      get :edit, {:id => escalation_rule.to_param}, valid_session
      expect(assigns(:escalation_rule)).to eq(escalation_rule)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new EscalationRule" do
        expect {
          post :create, {:escalation_rule => valid_attributes}, valid_session
        }.to change(EscalationRule, :count).by(1)
      end

      it "assigns a newly created escalation_rule as @escalation_rule" do
        post :create, {:escalation_rule => valid_attributes}, valid_session
        expect(assigns(:escalation_rule)).to be_a(EscalationRule)
        expect(assigns(:escalation_rule)).to be_persisted
      end

      it "redirects to the created escalation_rule" do
        post :create, {:escalation_rule => valid_attributes}, valid_session
        expect(response).to redirect_to(EscalationRule.last)
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { :name => 'sartaj'}
      }

      it "updates the requested escalation_rule" do
        escalation_rule = EscalationRule.create! valid_attributes
        put :update, {:id => escalation_rule.to_param, :escalation_rule => new_attributes}, valid_session
        escalation_rule.reload
        expect(assigns(:escalation_rule)).to be_a(EscalationRule)
        expect(assigns(:escalation_rule)).to be_persisted
      end

      it "assigns the requested escalation_rule as @escalation_rule" do
        escalation_rule = EscalationRule.create! valid_attributes
        put :update, {:id => escalation_rule.to_param, :escalation_rule => valid_attributes}, valid_session
        expect(assigns(:escalation_rule)).to eq(escalation_rule)
      end

      it "redirects to the escalation_rule" do
        escalation_rule = EscalationRule.create! valid_attributes
        put :update, {:id => escalation_rule.to_param, :escalation_rule => valid_attributes}, valid_session
        expect(response).to redirect_to(escalation_rule)
      end
    end

    describe "with invalid params" do
      it "assigns the escalation_rule as @escalation_rule" do
        @escalation_rule = EscalationRule.create! valid_attributes

        @escalation_rule.user=subject.current_user
        if @escalation_rule.save
          put :update, {:id => @escalation_rule.to_param, :escalation_rule => invalid_attributes}, valid_session
          expect(assigns(:escalation_rule)).to eq(@escalation_rule)
        else
          it "re-renders the 'edit' template" do
            @escalation_rule = EscalationRule.create! valid_attributes
            put :update, {:id => @escalation_rule.to_param, :escalation_rule => invalid_attributes}, valid_session
            expect(response).to render_template("edit")
          end
        end
      end
    end
  end
  describe "DELETE destroy" do
    it "destroys the requested escalation_rule" do
      escalation_rule = EscalationRule.create! valid_attributes
      expect {
        delete :destroy, {:id => escalation_rule.to_param}, valid_session
      }.to change(EscalationRule, :count).by(-1)
    end

    it "redirects to the escalation_rules list" do
      escalation_rule = EscalationRule.create! valid_attributes
      delete :destroy, {:id => escalation_rule.to_param}, valid_session
      expect(response).to redirect_to(root_path)
    end
  end

end
