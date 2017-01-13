source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0', '< 5.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'thin', '~> 1.6.1'

gem 'settingslogic', '~> 2.0.9'

# Colored output to console
gem "colorize", '~> 0.7.0'

# API
gem 'grape'
gem 'grape-entity'

gem 'dotenv-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'hashie'
gem 'uuidtools'

gem 'sidekiq', '~> 4.1.1'

gem "default_value_for"

gem 'awesome_nested_set'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', require: 'rack/cors'
gem 'oj'
gem 'ox'
gem 'kaminari'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'json_expressions', require: 'json_expressions/rspec'
  gem 'awesome_print', '~> 1.2.0', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'ffaker', '~> 2.0.0'
  gem 'rubocop', '~> 0.35.0', require: false
  gem 'rails-erd'
  gem 'rspec',   '~> 3.5.0.beta3'
  gem 'rspec-rails', '~> 3.5.0.beta3'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'webmock', '~> 1.21.0'
  gem 'test_after_commit', '~> 0.4.2'
  gem 'rspec-its'
  gem "rspec-request_describer"
end

group :development do
  gem 'annotate'
  gem 'listen'
end

group :production do
  gem "unicorn", '~> 4.9.0'
  gem 'unicorn-worker-killer', '~> 0.4.2'
end
