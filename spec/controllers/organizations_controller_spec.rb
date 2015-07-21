require 'rails_helper'

RSpec.describe OrganizationsController, :type => :controller do
  describe'GET /organization/:id' do
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
end
