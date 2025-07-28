class NotificationRequest < ApplicationRecord
    belongs_to :notification_template, foreign_key: :notification_template_key, primary_key: :key

    enum status: {
        queued: 'queued',
        processing: 'processing',
        sent: 'sent',
        failed: 'failed'
    }, _prefix: true

    validates :recipient, presence: true
    validates :channel, presence: true
    validates :status, presence: true
    
end