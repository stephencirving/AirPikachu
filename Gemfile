source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.7', '>= 5.0.7.2'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'sqlite3', '~> 1.3.13'

end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap-sass', '~> 3.3.6'
gem 'autoprefixer-rails'
gem 'devise', '~> 4.2'
gem 'bcrypt', '~> 3.1.7'
gem 'toastr-rails', '~> 1.0'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'omniauth', '~> 1.6'
gem 'omniauth-facebook', '~> 4.0'

gem 'aws-sdk', '~> 2.8'

gem 'paperclip', '~> 5.1.0'
gem 'climate_control'
gem 'cocaine'

gem 'geocoder', '~> 1.4'
gem 'jquery-ui-rails', '~> 5.0'

gem 'ransack', '~> 1.7'

#---- Air Kong ----
gem 'twilio-ruby', '~> 4.11.1'
