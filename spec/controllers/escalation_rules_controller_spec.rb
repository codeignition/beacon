require 'rails_helper'

RSpec.describe EscalationRulesController, :type => :controller do
  login_user

  let(:valid_attributes) {
    {:name=>"Akash",
     :organization=>(create :organization),
     airplane_mode_on: true,
     weekday_airplane_mode_on: true,
     weekend_airplane_mode_on: true
  }
  }

  let(:invalid_attributes) {
    {:name=>nil}
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all escalation_rules as @escalation_rules" do
      escalation_rule = EscalationRule.create! valid_attributes
      escalation_rule.user_id=subject.current_user.id
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
        contact = subject.current_user.contacts.first
        contact.confirmed_at = Time.now
        contact.save
        valid_attributes[:contacts] = {}
        valid_attributes[:contacts][:contact1] = Hash.new()
        valid_attributes[:contacts][:contact1]['id'] = contact.id
        valid_attributes[:contacts][:contact1]['level'] = "1"

        expect {
          post :create, {:escalation_rule => valid_attributes}, valid_session
        }.to change(EscalationRule, :count).by(1)
      end

      it "assigns a newly created escalation_rule as @escalation_rule" do
        contact = subject.current_user.contacts.first
        contact.confirmed_at = Time.now
        contact.save
        valid_attributes[:contacts] = {}
        valid_attributes[:contacts][:contact1] = Hash.new()
        valid_attributes[:contacts][:contact1]['id'] = contact.id
        valid_attributes[:contacts][:contact1]['level'] = "1"
        post :create, {:escalation_rule => valid_attributes}, valid_session
        expect(assigns(:escalation_rule)).to be_a(EscalationRule)
        expect(assigns(:escalation_rule)).to be_persisted
      end

      it 'assigns parameters sent with post request to @escalation rule' do
        contact = subject.current_user.contacts.first
        contact.confirmed_at = Time.now
        contact.save
        valid_attributes[:contacts] = {}
        valid_attributes[:contacts][:contact1] = Hash.new()
        valid_attributes[:contacts][:contact1]['id'] = contact.id
        valid_attributes[:contacts][:contact1]['level'] = "1"
        post :create, {:escalation_rule => valid_attributes}, valid_session
        expect(assigns(:escalation_rule).name).to eq("Akash")
        expect(assigns(:escalation_rule).airplane_mode_on).to eq(true)
        expect(assigns(:escalation_rule).weekend_airplane_mode_on).to eq(true)
        expect(assigns(:escalation_rule).weekday_airplane_mode_on).to eq(true)
      end

      it "redirects to the created escalation_rule" do
        contact = subject.current_user.contacts.first
        contact.confirmed_at = Time.now
        contact.save
        valid_attributes[:contacts] = {}
        valid_attributes[:contacts][:contact1] = Hash.new()
        valid_attributes[:contacts][:contact1]['id'] = contact.id
        valid_attributes[:contacts][:contact1]['level'] = "1"
        post :create, {:escalation_rule => valid_attributes}, valid_session
        expect(response).to redirect_to(EscalationRule.last)
      end

      it 'does not add an unverified contact to the escalation rule' do
        contact = subject.current_user.contacts.first
        valid_attributes[:contacts] = {}
        valid_attributes[:contacts][:contact1] = Hash.new()
        valid_attributes[:contacts][:contact1]['id'] = contact.id
        valid_attributes[:contacts][:contact1]['level'] = "1"
        post :create, {escalation_rule: valid_attributes}, valid_session
        expect(response.status).to eq(422)
      end

      it 'adds a verified contact to the esalation rule' do
        contact = subject.current_user.contacts.first
        contact.confirmed_at = Time.now
        contact.save
        valid_attributes[:contacts] = {}
        valid_attributes[:contacts][:contact1] = Hash.new()
        valid_attributes[:contacts][:contact1]['id'] = contact.id
        valid_attributes[:contacts][:contact1]['level'] = "1"
        post :create, {escalation_rule: valid_attributes}, valid_session
        expect(EscalationRule.count).to eq(1)
        expect(assigns(:escalation_rule)).to be_a(EscalationRule)
        expect(assigns(:escalation_rule)).to be_persisted
        expect(response).to redirect_to(EscalationRule.last)
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { :name => 'sartaj',
          :contacts=>Hash.new(subject.current_user.contacts.create)}
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
        contact = subject.current_user.contacts.create
        valid_attributes[:contacts] = Hash.new(contact)
        put :update, {:id => escalation_rule.to_param, :escalation_rule => valid_attributes}, valid_session
        expect(assigns(:escalation_rule)).to eq(escalation_rule)
      end

      it "redirects to the escalation_rule" do
        escalation_rule = EscalationRule.create! valid_attributes
        contact = subject.current_user.contacts.create
        valid_attributes[:contacts] = Hash.new(contact)
        put :update, {:id => escalation_rule.to_param, :escalation_rule => valid_attributes}, valid_session
        expect(response).to redirect_to(escalation_rule)
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
