class OnboardingMailer < ActionMailer::Base
  default from: "hi@getbeacon.in"
  def send_invitation_email(user,name,invitor, phone_number, org)
    @user = user
    @invitor = invitor
    @phone_number = phone_number
    @org = org
    @name = name
    mail(to: @user.email, subject: "#{@invitor} invites you to join #{@org} on Beacon")
  end

  def missed_beacon_alert_email(escalation_rule, complaint)
    @escalation_rule = escalation_rule
    @organization = Organization.where(id: escalation_rule.organization)
    @complaint = complaint
    @admin = User.where(id: OrganizationUser.where(organization: @organization, is_admin: true).first.user_id).first
    mail(to: @admin.email, subject: "Missed Beacon Alert for #{@escalation_rule.name}")
  end
end
