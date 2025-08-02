class NotificationSenderJob
    include Sidekiq::Job

    def perform(notification_request_id)
        request = NotificationRequest.find_by(id: notification_request_id)
        return unless request && request.queued?
        request.update!(status: :processing)

        template = request.notification_template
        success, provider_response = EmailService.send(
            recipient: request.recipient,
            title: template.default_title,
            body: template.default_body
        )

        if success
            request.update!(status: :sent, sent_at: Time.current)
        else
            request.update!(status: :failed,  provider_response: provider_response)
        end
    rescue => e
        Rails.logger.error("Error en NotificationSenderJob: #{e.message}")
        request.update!(status: :failed, provider_response: { error: e.message }) if request
    end
end
