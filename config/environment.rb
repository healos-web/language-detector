require 'bundler'
require 'active_support/all'
Bundler.require
require 'pry'

DetectLanguage.configure do |config|
  config.api_key = "YOUR API KEY"

  # enable secure mode (SSL) if you are passing sensitive data
  # config.secure = true
end

require_all 'app'
