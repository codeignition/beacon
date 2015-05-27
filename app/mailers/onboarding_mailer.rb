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
end
