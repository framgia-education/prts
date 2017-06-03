namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    u = User.create name: "Admin", email: "admin@prts.com", password: "prts@123",
      password_confirmation: "prts@123", role: :admin

    WhiteList.create! github_account: "['huongnguyenmta', 'oHoangThiNhung', 'dieunb',
      'thangtx88', 'Framgia-HoVanTuan', 'hungnh103']"
  end
end
