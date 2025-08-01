class NotificationRequest < ApplicationRecord
    belongs_to :notification_template

    enum status: {
        queued: "queued",
        processing: "processing",
        sent: "sent",
        failed: "failed"
    }

    validates :recipient, presence: true
    validates :channel, presence: true
    validates :status, presence: true
end
