require "rails_helper"

RSpec.describe NotificationSenderJob, type: :job do
    let!(:template) { NotificationTemplate.create(key: "foo_notification", default_title: "Test Title", default_body: "Test Body") }
    let!(:notification_request) { NotificationRequest.create(notification_template: template, recipient: "abc@test.com", channel: "EMAIL", status: "queued") }

    let(:email_service_double) { instance_double(EmailService) }

    before do
        allow(ChannelFactory).to receive(:for).with("EMAIL").and_return(email_service_double)
    end

    context "Cuando el envio es exitoso" do
        it "actualiza el estado del request a sent" do
            allow(email_service_double).to receive(:send).and_return([ true, { message: "Success" } ])
            described_class.new.perform(notification_request.id)
            expect(notification_request.reload.status).to eq('sent')
        end
    end

    context "Cuando el envio falla" do
        it "actualiza el estado del request a failed" do
            allow(email_service_double).to receive(:send).and_return([ false, { error: "Invalid API Key" } ])
            described_class.new.perform(notification_request.id)
            expect(notification_request.reload.status).to eq("failed")
            expect(notification_request.reload.provider_response).to eq({ "error" => "Invalid API Key" })
        end
    end
end
