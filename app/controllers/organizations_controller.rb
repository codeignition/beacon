class OrganizationsController < ApplicationController
  def update
    
    respond_to do |format|
      if Organization.find(params[:id]).update(name: params[:organization][:name])
        format.html { redirect_to root_path, notice: 'Organization Was saved successfully.' }
        format.json { render json: {message: 'success'} }
      end

    end
  end

  def create
    respond_to do |format|
      if params[:organization][:name] and !params[:organization][:name].empty?
        @org = Organization.create(name: params[:organization][:name])
        @orgUser = OrganizationUser.create(user: current_user, organization: @org, is_admin: true)
     
        format.html { redirect_to root_path, notice: 'Organization Was saved successfully.' }
        format.json { render json: {message: 'success'} }
      end
    end
  end

  def destroy
    respond_to do |format|
      Organization.find(params[:id]).destroy
     
      format.html { redirect_to root_path, notice: 'Organization Was deleted successfully.' }
      format.json { render json: {message: 'success'} }
    end
  end

  def set_organization
    if current_user.organizations.ids.include?(params[:id].to_i)
      self.current_org = params[:id].to_i
      render json: {message: 'success'}
    else
      render json: {message: 'invalid request'}
    end
  end

end
