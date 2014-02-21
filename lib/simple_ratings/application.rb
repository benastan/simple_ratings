require 'json'
require 'pry'
require 'sinatra/base'
require 'simple_ratings/assets'
require 'simple_ratings/foursquare'

module SimpleRatings
  class Application < Sinatra::Base
    get '/' do
      erb :'application/index', layout: :'layouts/application'
    end

    post '/search.?:format?' do
      foursquare.search(params[:search]).body
    end

    get '/venues/:id' do
      foursquare.get("venues/#{params[:id]}").body
    end

    protected

    def assets
      @assets ||= Assets.new(File.expand_path('../../..', __FILE__))
    end

    def foursquare
      @foursquare ||= Foursquare.new
    end
  end
end
