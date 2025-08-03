module ChannelFactory
    CHANNEL_MAP = {
        "EMAIL" => EmailService
    }.freeze

    def self.for(channel_name)
        service_class = CHANNEL_MAP[channel_name]
        service_class
    end
end
