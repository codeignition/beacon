class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json
  def create
    super
    if @user.errors.empty?
      org_name = @user.email.match(/.+@(.+)/)[1]
      org = Organization.create(name: org_name)
      org_user = OrganizationUser.create(organization_id: org.id, user_id: @user.id)
      org_user.is_admin = true unless org.users.count > 1
      session[:org_id] = org.id
      org_user.save
      @user.save
      @user.send_confirmation_instructions if @user
      sign_in(resource_name, resource)
    end
  end
 
end