class NotificationSenderJob
    include Sidekiq::Job

    def perform(notification_request_id)
        request = NotificationRequest.find_by(id: notification_request_id)
        return unless request

        return unless request.status_queued?

        request.update!(status: :processing)

        notification_class = AbstractNotificacion.known_notifications[request.notification_template_key]

        unless notification_class
            raise "Clase de notificación no válida o no registrada: #{request.notification_template_key}"
        end

        EmailService.send(
            recipient: request.recipient,
            title: notification_class.title,
            body: notification_class.body
        )

        request.update!(status: :sent, sent_at: Time.current)
    rescue => e
        Rails.logger.error("Error en NotificationSenderJob: #{e.message}")
        request.update!(status: :failed, provider_response: { error: e.message }) if request
    end
end
