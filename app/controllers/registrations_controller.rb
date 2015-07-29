class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json
  def create
    build_resource(sign_up_params)
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      if User.where(email: resource.email).first.sign_in_count == 0
        @user.errors.messages[:sign_in_count] = "User exists but never Signed in!"
        @user.errors.messages[:email_id] = @user.email
      end
      respond_with resource
    end
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
