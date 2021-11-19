source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.0"
gem "bootsnap", ">= 1.4.4", require: false
gem "jbuilder", "~> 2.7"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.4", ">= 6.1.4.1"
gem "sass-rails", ">= 6"
gem "sqlite3", "~> 1.4"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"
group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
group :development, :test do
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end
group :development, :test do
  gem "dotenv-rails"
  gem "factory_bot"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 4.0.1"
  gem "shoulda-matchers", "~> 5.0"
end
gem "bcrypt"
gem "bootstrap5-kaminari-views"
gem "cancancan"
gem "config"
gem "devise"
gem "faker", git: "https://github.com/faker-ruby/faker.git", branch: "master"
gem "jquery-rails"
gem "kaminari"
gem "simplecov"
gem "simplecov-rcov"
