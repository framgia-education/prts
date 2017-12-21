source "https://rubygems.org"

ruby "2.4.0"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt", "3.1.11"
gem "bootstrap-sass"
gem "bootstrap4-kaminari-views"
gem "chatwork"
gem "chosen-rails"
gem "config"
gem "font-awesome-rails"
gem "jquery-rails"
gem "kaminari"
gem "omniauth-framgia", git: "https://github.com/framgia-education/omniauth-framgia.git"
gem "puma", "~> 3.0"
gem "rails", "~> 5.0.2"
gem "redis", "3.3.3"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platform: :mri
  gem "pry"
  gem "sqlite3"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
