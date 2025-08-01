class NotificationTemplate < ApplicationRecord
    has_many :notification_requests

    validates :key, presence: true, uniqueness: true
end
