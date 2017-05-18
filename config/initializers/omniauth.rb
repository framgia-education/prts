Rails.application.config.middleware.use OmniAuth::Builder do
  APP_ID = "c550483e49706ba821bccc6bac3f3b1e"
  APP_SECRET = "3b438b7cd973829cfa5233396968267c6c7aef298374561e6d4b4dc26c510b5c"

  provider :hr_system, APP_ID, APP_SECRET
  # provider :hr_system, ENV["APP_ID"], ENV["APP_SECRET"]
end
