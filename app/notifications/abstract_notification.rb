class AbstractNotification
    def self.title
        raise NotImplementedError, "#{self.name} debe implementar el método .title"
    end

    def self.body
        raise NotImplementedError, "#{self.name} debe implementar el método .body"
    end

    def self.send(recipient)
        NotificationCenter.enqueue_request(
            notification_key: self.key,
            recipient: recipient,
            channel: "EMAIL"
        )
    end

    def self.key
        self.name.underscore
    end

    def self.know_notifications
        Dir[Rails.root.join("app", "notifications", "*.rb")].each { |file| require file }
        self.descendants.index_by(&:key)
    end
end
