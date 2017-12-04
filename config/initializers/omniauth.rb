Rails.application.config.middleware.use OmniAuth::Builder do
  provider :framgia, ENV["TMS_APP_ID"], ENV["TMS_APP_SECRET"],
    client_options: {
      site: "https://education.framgia.vn/",
      authorize_url: "https://education.framgia.vn/authorize",
      token_url: "https://education.framgia.vn/auth/access_token"
    }
end
