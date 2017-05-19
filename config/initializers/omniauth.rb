Rails.application.config.middleware.use OmniAuth::Builder do
  # APP_ID = "c550483e49706ba821bccc6bac3f3b1e"
  # APP_SECRET = "3b438b7cd973829cfa5233396968267c6c7aef298374561e6d4b4dc26c510b5c"
  APP_ID = "UCBB1He8Lnn33RDJWMsiX63n"
  APP_SECRET = "f7cf591975153b7c371c39946942b7793bf3f762b02314d0c3a948fcdeba"
  provider :hr_system, APP_ID, APP_SECRET
  # provider :hr_system, ENV["APP_ID"], ENV["APP_SECRET"]
end
