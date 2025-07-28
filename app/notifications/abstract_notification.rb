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
            channel: 'EMAIL'
        )
    end

    def self.key
        self.name.underscore
    end
end