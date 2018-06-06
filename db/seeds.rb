User.create! name: "Admin", email: "admin@prts.com", password: "123456",
  password_confirmation: "123456", role: :admin

WhiteList.create! github_account: "['hungnh103', 'huongnguyenmta', 'dieunb', 'thangtx88', 'yeunuthongminh', 'DoanVanToan', 'trinhductoan', 'nvtanh', 'tranducquoc', 'phamvanbk11', 'dothidiemthao', 'at-diephq', 'hhhhuy112', 'daolq3012']"

Office.create! name: "Handico", address: "11F Handico Building, Pham Hung road, Nam Tu Liem dist., Ha Noi"
Office.create! name: "Laboratory", address: "9F HTP Building, 434 Tran Khat Chan Str., Ha Noi"
Office.create! name: "Da Nang", address: "6F Vinh Trung Plaza, 255~257 Hung Vuong Str., Da Nang"
