Rails.application.config.middleware.use OmniAuth::Builder do
  provider :hr_system, ENV["HR_APP_ID"], ENV["HR_APP_SECRET"]
end
