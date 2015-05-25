class ApplicationController < ActionController::Base

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    alerts_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def current_org
    session[:org_id] ||= current_user.organizations.first.id
    if Organization.where(id: session[:org_id]).first
      @current_org ||= Organization.find(session[:org_id])
    else
      @current_org ||= current_user.organizations.first
    end
  end
   
  def current_org=(id)
    session[:org_id] = id
    @current_org ||= Organization.find(session[:org_id])
  end
  
  def toggle_tour
    current_user.update(tour_taken: !current_user.tour_taken)
    sign_in(current_user, :bypass => true)
    render json: {message: 'success'}
  end

  def home
    if current_user.nil?
      render :template => "home/landing"
    else
      if current_user.contacts.empty?
        redirect_to setup_1_path
      else
        redirect_to alerts_path
      end
    end
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_configuration, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login,:username, :email, :password, :remember_me) }
  end
end
