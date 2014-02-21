require 'bundler'
Bundler.require
require 'simple_ratings/application'

map '/assets' do
  run SimpleRatings::Assets.new('.')
end

run SimpleRatings::Application