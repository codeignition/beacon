require "rails_helper"

RSpec.describe OnboardingMailer, :type => :mailer do
  describe 'missed_beacon_alert_email' do

    let(:admin) {User.create(email: 'person1@example.com')}
    let(:organization) {Organization.create(name: 'sample organization')}
    let(:organization_user) {OrganizationUser.create(user: admin, organization: organization)}
    let(:escalation_rule) {EscalationRule.create(name: 'Sample Rule', organization: organization)}
    let(:complaint) {Complaint.create(escalation_rule: escalation_rule, organization: organization)}
    let(:mail) {OnboardingMailer.missed_beacon_alert_email(escalation_rule, complaint)}

    it 'renders the subject' do
      organization_user.is_admin = true
      organization_user.save
      expect(mail.subject).to eql('Missed Beacon Alert for Sample Rule')
    end

    it 'renders the receiver email' do
      organization_user.is_admin = true
      organization_user.save
      expect(mail.to).to eql([admin.email])
    end

    it 'renders the sender email' do
      organization_user.is_admin = true
      organization_user.save
      expect(mail.from).to eql(['hi@getbeacon.in'])
    end

    it 'assigns @name' do
      organization_user.is_admin = true
      organization_user.save
      expect(mail.body.encoded).to match(admin.username)
      puts mail.body.encoded
      puts admin.username
    end
  end
end
