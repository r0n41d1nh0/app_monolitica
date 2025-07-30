class NotificationTemplate < ApplicationRecord
    has_many :notification_requests, foreign_key: :notification_template_key, primary_key: :key

    validates :key, presence: true, uniqueness: true
end
