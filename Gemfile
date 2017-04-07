source 'http://rubygems.org'

# To allow rails console to work on heroku dynos
gem 'rails', '3.2.22'
gem 'test-unit'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'
gem 'pg', '~> 0.18.4'
group :production do
  gem 'thin'
end
gem 'pundit'

gem 'rack-cors', :require => 'rack/cors'

# Use unicorn as the web server
gem 'unicorn'

# Your Gemfile.lock is corrupt. The following gem is missing from the DEPENDENCIES section: 'activesupport'
# https://makandracards.com/makandra/43292-bundler-gemfile-lock-is-corrupt-gems-are-missing-from-the-dependencies-section
gem 'activesupport'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
