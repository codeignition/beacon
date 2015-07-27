require 'rails_helper'

RSpec.describe OrganizationsController, :type => :controller do
  login_user
  describe'GET show' do
    it 'should set current_org to organization with requested id' do
      org = Organization.create
      get :show, {id: org.id}
      expect(subject.current_org).to eq(org)
    end

    it 'should redirect to settings page' do
      org = Organization.create
      get :show, {id: org.id}
      expect(response).to redirect_to(settings_path)
    end
  end

  describe 'POST create' do
    it 'adds admin as a team member to the organization' do
      subject.current_user.contacts.create(name: "hari", email_id: "hariomg@codeignition.co", phone_number: "08003574448", confirmed_at: Time.now)
      post :create, {organization: {name: "New Organization"}}
      expect(assigns(:org).contacts.count).to eq(1)
      expect(assigns(:org).contacts.first.name).to eq(Contact.where(user: subject.current_user).order(confirmed_at: :desc).first.name)
      expect(assigns(:org).contacts.first.email_id).to eq( Contact.where(user: subject.current_user).order(confirmed_at: :desc).first.email_id)
      expect(assigns(:org).contacts.first.phone_number).to eq( Contact.where(user: subject.current_user).order(confirmed_at: :desc).first.phone_number)
    end
  end

  describe 'DELETE destroy' do
    it 'does not let user destroy his first organization' do
      expect{
        delete :destroy, {id: subject.current_user.organizations.first.id}
      }.to change(Organization, :count).by(0)
    end
  end
end
