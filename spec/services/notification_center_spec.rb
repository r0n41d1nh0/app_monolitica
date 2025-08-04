require "rails_helper"

RSpec.describe NotificationCenter, type: :service do
    describe '.enqueue_request' do
        let!(:template) { NotificationTemplate.create(key: 'foo_notification', default_title: "Test") }

        it "Crea un NotificationRequest con estado queued" do
            expect {
                NotificationCenter.enqueue_request(notification_key: "foo_notification", recipient: "abc@test.com", channel: "EMAIL")
            }.to change(NotificationRequest, :count).by(1)

            created_request = NotificationRequest.last
            expect(created_request.status).to eq("queued")
        end

        it "Encola un NotificationSenderJob en Sidekiq con el ID corecto" do
            NotificationCenter.enqueue_request(notification_key: "foo_notification", recipient: "abc@test.com", channel: "EMAIL")
            expect(NotificationSenderJob.jobs.size).to eq(1)
            created_request_id = NotificationRequest.last.id
            expect(NotificationSenderJob.jobs.last["args"]).to eq([ created_request_id ])
        end
    end
end
