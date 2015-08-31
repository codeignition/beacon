require 'rails_helper'

RSpec.describe ComplaintController, :type => :controller do
  describe 'GET #resolve_complaint' do
    context 'with invalid complaint_id' do
      it 'returns "bad request"' do
        get :resolve_complaint, {complaint_id: nil}
        expect(response.status).to eq(400)
      end
    end

    context 'with valid complaint_id', :vcr do
      context 'when complaints status is set to pending' do
        it 'changes the status of complaint to "resolved"' do
          organization = Organization.create
          escalation_rule = EscalationRule.create(name: 'sample rule', organization: organization)
          contact = Contact.create(name: 'name', phone_number: '1234567890', email_id: '123@example.com')
          level = Level.new(escalation_rule_id: escalation_rule.id, contact_id: contact.id, level_number: '1')
          level.save
          complaint = Complaint.create(status: 'pending', escalation_rule_id: escalation_rule.id)
          get :resolve_complaint, {complaint_id: complaint.id}
          complaint.reload
          expect(complaint.status).to eq('resolved')
        end

        it 'calls OdinClient#terminate_pending_calls' do
          organization = Organization.create
          escalation_rule = EscalationRule.create(name: 'sample rule', organization: organization)
          contact = Contact.create(name: 'name', phone_number: '1234567890', email_id: '123@example.com')
          level = Level.new(escalation_rule_id: escalation_rule.id, contact_id: contact.id, level_number: '1')
          level.save
          complaint = Complaint.create(status: 'pending', escalation_rule_id: escalation_rule.id)
          expect(OdinClient).to receive(:terminate_pending_calls)
          get :resolve_complaint, {complaint_id: complaint.id}
        end
      end

      context 'when complaint status is not pending' do
        it 'sets the complaint status to resolved' do
          organization = Organization.create
          escalation_rule = EscalationRule.create(name: 'sample rule', organization: organization)
          contact = Contact.create(name: 'name', phone_number: '1234567890', email_id: '123@example.com')
          level = Level.new(escalation_rule_id: escalation_rule.id, contact_id: contact.id, level_number: '1')
          level.save
          complaint = Complaint.create(status: 'failed', escalation_rule_id: escalation_rule.id)
          get :resolve_complaint, {complaint_id: complaint.id}
          complaint.reload
          expect(complaint.status).to eq('resolved')
        end
        it 'does not call OdinClient#terminate_pending_calls' do
          complaint = Complaint.create
          complaint.status = 'failed'
          complaint.save
          expect(OdinClient).to_not receive(:terminate_pending_calls)
          get :resolve_complaint, {complaint_id: complaint.id}
        end
      end
    end
  end
end
