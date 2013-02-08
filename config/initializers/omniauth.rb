OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '131364997031342', '44c516fb668a71852347686ec508cbef'
end
