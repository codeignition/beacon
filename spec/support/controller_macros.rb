module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin)
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      contact = create :contact, {name: user.username, email_id: user.email, phone_number: "1234567890"}
      user.contacts.push(contact)
      organization = create :organization
      OrganizationUser.create(user: user, organization: organization, is_admin: true)
      user.organizations = [organization]
      user.save
      sign_in user
    end
  end
end

