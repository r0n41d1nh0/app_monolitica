module NotificationCenter
    def self.enqueue_request(notification_key:, recipient:, channel:)
        template = NotificationTemplate.find_by(key: notification_key)
        unless template
            Rails.logger.error("Plantilla de notificación no encontrada: #{notification_key}")
            return
        end

        ActiveRecord::Base.transaction do
            request = NotificationRequest.create!(
                notification_template: template,
                recipient: recipient,
                channel: channel,
                status: :queued
            )
            NotificationSenderJob.perform_async(request.id)
        end
    rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error("Error al crear NotificationRequest: #{e.message}")
    end
end
