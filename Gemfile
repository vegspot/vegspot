source 'https://rubygems.org'

gem 'rails', '4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

gem 'slim-rails'

gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'

gem 'carrierwave'
gem 'rmagick'

gem 'turbolinks'

gem 'rails-timeago', '~> 2.0'

gem 'nokogiri'

gem 'acts-as-taggable-on'

gem 'thumbs_up'

# pagination
gem 'kaminari'

# I'm temporary changing cancan gem source to blischalk's source
# to make it working well on rails4
gem "cancan", github: 'blischalk/cancan', branch: 'ForbiddenAttributes'

gem 'share_counts', github: 'vitobotta/share_counts'

# Use this repo / branch to make it rails4 compatibile
gem 'acts_as_commentable_with_threading', git: 'git@github.com:petergoldstein/acts_as_commentable_with_threading.git', branch: 'feature/rails_4'

# Markdown support
gem 'redcarpet'

# sheduled tasks / cron replacement
gem 'clockwork'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0'
  gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.3.0'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'spork-rails'
end
