namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    # Make admin account
    u = User.create name: "admin", email: "admin@prts.com", password: "prts@123",
      password_confirmation: "prts@123", role: :admin
  end
end
