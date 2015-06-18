require 'rails_helper'

RSpec.describe ContactsController, :type => :controller do

  login_user

  let(:valid_attributes){
    {:name =>"Sartaj",
     :phone_number => "9999999999",
     :email_id => "sa@email.com"
  }}

  let(:invalid_attributes){
    {:name =>nil,
     :phone_number =>nil,
  }}

  let(:valid_session) {{
  }
  }

  describe "GET index" do
    it "assigns all contacts as @contacts" do
      contact =Contact.create! valid_attributes
      contact.user=subject.current_user
      contact.save
      get :index, {},valid_session
      expect(assigns(:contacts)).to eq(subject.current_user.contacts)
    end
  end

  describe "GET show" do
    it "assigns the requested contact as @contact" do
      contact = Contact.create! valid_attributes
      get :show, {:id => contact.to_param}, valid_session
      expect(assigns(:contact)).to eq(contact)
    end
  end

  describe "GET new" do
    it "assigns a new contact as @contact" do
      get :new, {}, valid_session
      expect(assigns(:contact)).to be_a_new(Contact)
    end
  end

  describe "GET edit" do
    it "assigns the requested contact as @contact" do
      contact = Contact.create! valid_attributes
      get :edit, {:id => contact.to_param}, valid_session
      expect(assigns(:contact)).to eq(contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Contact" do
        expect {
          post :create, {:contact => valid_attributes}, valid_session
        }.to change(Contact, :count).by(1)
      end

      it "assigns a newly created contact as @contact" do
        post :create, {:contact => valid_attributes}, valid_session
        expect(assigns(:contact)).to be_a(Contact)
        expect(assigns(:contact)).to be_persisted
      end

      it "redirects to the created contact" do
        post :create, {:contact => valid_attributes}, valid_session
       expect(response).to redirect_to(root_path)
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { :name => 'akash' ,
          :phone_number => '1111111111' ,
          :email_id => 'random@example.com',
      }}

      it "updates the requested contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => new_attributes}, valid_session
        contact.reload 
        expect(assigns(:contact)).to be_a(Contact)
        expect(assigns(:contact)).to be_persisted
      end

      it "assigns the requested contact as @contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session
        expect(assigns(:contact)).to eq(contact)
      end

      it "redirects to the contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "assigns the contact as @contact" do
        @contact = Contact.create! valid_attributes

        @contact.user=subject.current_user
        if @contact.save
          put :update, {:id => @contact.to_param, :contact => invalid_attributes}, valid_session
          expect(assigns(:contact)).to eq(@contact)
        else
          it "re-renders the 'edit' template" do
            @contact = Contact.create! valid_attributes
            put :update, {:id => @contact.to_param, :contact => invalid_attributes}, valid_session
            expect(response).to render_template("edit")
          end
        end 
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, {:id => contact.to_param}, valid_session
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to the contacts list" do
      contact = Contact.create! valid_attributes
      delete :destroy, {:id => contact.to_param}, valid_session
      expect(response).to redirect_to(settings_path)
    end
  end
end
