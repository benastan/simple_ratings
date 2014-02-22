require 'bundler'
Bundler.require

ENV['DATABASE_URL'] = ENV['TEST_DATABASE_URL']

require 'simple_ratings/application'

RSpec.configure do |config|
  config.around(:each) do |example|
    SimpleRatings::Database.transaction(rollback: :always) do
      example.run
    end
  end
end