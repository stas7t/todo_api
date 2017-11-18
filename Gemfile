# frozen_string_literal: true

source 'https://rubygems.org'

gem 'dotenv-rails', require: 'dotenv/rails-now'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

group :production do
  gem 'pg', '~> 0.21'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_girl_rails', '~> 4.8'
  gem 'rspec-rails', '~> 3.6'
  gem 'sqlite3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application
  # running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
end

gem 'carrierwave', '~> 1.0'
gem 'carrierwave-base64', '~> 2.6'
gem 'file_validators'
gem 'fog-aws'

gem 'jwt', '~> 2.1.0'
gem 'rack-cors', require: 'rack/cors'
gem 'simple_command', '~> 0.0.9'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
