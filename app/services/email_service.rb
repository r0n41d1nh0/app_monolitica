class EmailService
    def self.send(recipient:, title:, body:)
        puts "Enviando email a #{recipient} con título '#{title}'"
    end
end