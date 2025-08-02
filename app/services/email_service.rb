require "sendgrid-ruby"

class EmailService
    include SendGrid
    def self.send(recipient:, title:, body:)
        # puts "Enviando email a #{recipient} con título '#{title}'"
        from = Email.new(email: "criosoftpe@gmail.com")
        to = Email.new(email: recipient)
        subject = title
        content = Content.new(type: "text/plain", value: body)
        mail = Mail.new(from, subject, to, content)
        api_key = Rails.application.credentials.sendgrid_api_key
        sg = SendGrid::API.new(api_key: api_key)

        response = sg.client.mail._("send").post(request_body: mail.to_json)
        if response.status_code.to_i.between?(200, 299)
            puts "Email enviado a #{recipient} con éxito."
            [ true, response.body ]
        else
            puts "Error al enviar email a #{recipient}: #{response.body}"
            [ false, response.body ]
        end
    rescue => e
        puts "Excepción al enviar email: #{e.message}"
        [ false, { error: e.message } ]
    end
end
