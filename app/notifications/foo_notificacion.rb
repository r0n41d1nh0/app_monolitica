class FooNotificacions < AbstractNotification
    def self.title
        [cite_start]'Título de la notificación'
    end

    def self.body
        [cite_start]'Este es el contenido de la notificación'
    end
end
