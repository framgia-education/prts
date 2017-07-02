User.create! name: "Admin", email: "admin@prts.com", password: "prts@123",
  password_confirmation: "prts@123", role: :admin

WhiteList.create! github_account: "['huongnguyenmta', 'oHoangThiNhung', 'dieunb',
  'thangtx88', 'Framgia-HoVanTuan', 'hungnh103', 'yeunuthongminh', 'hellovietnam93',
  'dat-hedspi', 'DoanVanToan', 'trinhductoan', 'vietmt', 'nvtanh', 'tranducquoc',
  'phamvanbk11', 'dothidiemthao', 'at-diephq', 'hhhhuy112', 'daolq3012']"

Office.create! name: "Toong", address: "2F 25T2 Hoang Dao Thuy Str., Ha Noi"
Office.create! name: "Laboratory", address: "9F HTP Building, 434 Tran Khat Chan Str., Ha Noi"
Office.create! name: "Da Nang", address: "6F Vinh Trung Plaza, 255~257 Hung Vuong Str., Da Nang"
