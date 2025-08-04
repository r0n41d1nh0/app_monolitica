require "rails_helper"

RSpec.describe "Flujo completo de envio de notificaciones", type: :request do
    let!(:template) { NotificationTemplate.create(key: "foo_notification", default_title: "Test Title", default_body: "Test Body") }

    before do
        Sidekiq::Testing.inline!
        allow(ChannelFactory).to receive(:for).with("EMAIL").and_return(EmailService)
        allow(EmailService).to receive(:send).and_return(true)
    end

    after do
        Sidekiq::Testing.fake!
    end

    it "crea una solicitud y actualiza su estado a sent después de procesar el job" do
        FooNotification.send("test@example.com")
        notification_request = NotificationRequest.last
        expect(notification_request.status).to eq("sent")
        expect(notification_request.sent_at).to be_present
        expect(EmailService).to have_received(:send).once
    end
end
