require 'rails_helper'


RSpec.describe LevelsController, :type => :controller do
login_user

  let(:valid_attributes) {
    {:escalation_rule_id=> "1",
     :contact_id=> "2",
     :level_number=> "2" }
  }

  let(:invalid_attributes) {

    {:escalation_rule_id=> "1",
     :contact_id=> nil,
     :level_number=> nil }}

  let(:valid_session) { {} }


  describe "GET show" do
    it "assigns the requested level as @level" do
      level = Level.create! valid_attributes
      level.save
      get :show, {:id => level.to_param}, valid_session
      expect(assigns(:level)).to eq(level)
    end
  end

  describe "GET new" do
    it "assigns a new level as @level" do
      get :new, {}, valid_session
      expect(assigns(:level)).to be_a_new(Level)
    end
  end

  describe "GET edit" do
    it "assigns the requested level as @level" do
      level = Level.create! valid_attributes
      get :edit, {:id => level.to_param}, valid_session
      expect(assigns(:level)).to eq(level)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Level" do
        expect {
          post :create, {:level => valid_attributes}, valid_session
        }.to change(Level, :count).by(1)
      end

      it "assigns a newly created level as @level" do
        post :create, {:level => valid_attributes}, valid_session
        expect(assigns(:level)).to be_a(Level)
        expect(assigns(:level)).to be_persisted
      end

      it "redirects to the created level" do
        post :create, {:level => valid_attributes}, valid_session
        expect(response).to redirect_to(escalation_rule_path(valid_attributes[:escalation_rule_id]))
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {:escalation_rule_id=> "7",
         :contact_id=> "5",
         :level_number=> "2" }
      }

      it "updates the requested level" do
        level = Level.create! valid_attributes
        put :update, {:id => level.to_param, :level => new_attributes}, valid_session
        level.reload

        expect(assigns(:level)).to be_a(Level)
        expect(assigns(:level)).to be_persisted
      end

      it "assigns the requested level as @level" do
        level = Level.create! valid_attributes
        put :update, {:id => level.to_param, :level => valid_attributes}, valid_session
        expect(assigns(:level)).to eq(level)
      end

      it "redirects to the level" do
        level = Level.create! valid_attributes
        put :update, {:id => level.to_param, :level => valid_attributes}, valid_session
        expect(response).to redirect_to(escalation_rule_path)
      end
    end

    describe "with invalid params" do
      it "assigns the level as @level" do
        @level = Level.create! valid_attributes
        if @level.save
          put :update, {:id => @level.to_param, :level => invalid_attributes}, valid_session
          expect(assigns(:level)).to eq(@level)
        else 
          it "re-renders the 'edit' template" do
            @level = Level.create! valid_attributes
            put :update, {:id => @level.to_param, :level => invalid_attributes}, valid_session
            expect(response).to render_template("edit")
          end
        end
      end
    end
  end
  describe "DELETE destroy" do
    it "destroys the requested level" do
      level = Level.create! valid_attributes
      expect {
        delete :destroy, {:id => level.to_param}, valid_session
      }.to change(Level, :count).by(-1)
    end

    it "redirects to the levels list" do
      level = Level.create! valid_attributes
      delete :destroy, {:id => level.to_param}, valid_session
      expect(response).to redirect_to(escalation_rule_path)
    end
  end

end
