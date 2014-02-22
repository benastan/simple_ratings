require 'json'
require 'pry'
require 'sinatra/base'
require 'simple_ratings/assets'
require 'simple_ratings/foursquare'
require 'simple_ratings/user'
require 'simple_ratings/database'
require 'simple_ratings/rating'

module SimpleRatings
  class Application < Sinatra::Base
    get '/' do
      erb :'application/index', layout: :'layouts/application'
    end

    post '/search.?:format?' do
      foursquare.search(params[:search]).body
    end

    get '/venues/:id' do
      meta = Foursquare::Meta::Venue.new(params[:id], current_user.id)
      
      venue = JSON.parse(foursquare.get("venues/#{params[:id]}").body)

      venue['response']['venue']['meta'] = meta

      JSON.dump(venue)
    end

    get '/venues/:id/ratings' do
      Rating.where(venue_id: params[:id]).group(:venue_id).having('created_at = max(created_at)')

      JSON.dump(SimpleRatings::Rating.where_venue(venue_id))
    end

    post '/venues/:id/rating' do
      rating = Rating.create(
        user_id: current_user.id,
        venue_id: params[:id],
        stars: params[:rating][:stars]
      )

      JSON.dump(rating)
    end
    
    protected

    def current_user
      User.new(1)
    end

    def assets
      @assets ||= Assets.new(File.expand_path('../../..', __FILE__))
    end

    def foursquare
      @foursquare ||= Foursquare.new
    end
  end
end
