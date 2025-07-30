module NotificationCenter
    def self.enqueue_request(notification_key:, recipient:, channel:)
        ActiveRecord::Base.transaction do
            request = NotificationRequest.create!(
                notification_template_key: notification_key,
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
