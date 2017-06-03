Rails.application.config.middleware.use OmniAuth::Builder do
  provider :hr_system, "c550483e49706ba821bccc6bac3f3b1e", "3b438b7cd973829cfa5233396968267c6c7aef298374561e6d4b4dc26c510b5c"
  # provider :hr_system, ENV["HR_APP_ID"], ENV["HR_APP_SECRET"]
end
