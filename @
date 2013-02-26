class PhoneGateway
  def self.send_text_message(number, message)
    config = YAML::load_file(File.join(Rails.root, "config", "twilio.yml"))
    client  = Twilio::REST::Client.new config['account_sid'], config['auth_token']
    client.account.sms.messages.create(
      from: '+1 920-268-1819',
      to: number,
      body: message
    )
  end
end
