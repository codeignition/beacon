class WelcomeController < ApplicationController


  before_filter :authenticate_user!

  def result
    if(!OrganizationUser.where(user: current_user, organization: current_org, is_admin: true).empty?)
      @organizations = current_user.organizations
      @contacts = current_org.contacts
      @escalation_rules = current_org.escalation_rules
      @new_escalation_rule = EscalationRule.new
      @new_contact = Contact.new
      @current_org = current_org
    else
      redirect_to alerts_path
    end
  end


  def setup_1
    if current_org.contacts.empty?
      @new_contact = Contact.new
      @current_org = current_org
    else
      redirect_to alerts_path
    end
  end

end
