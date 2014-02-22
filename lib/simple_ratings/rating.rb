require 'simple_ratings/database'
require 'simple_ratings/sql/venue_ratings'

module SimpleRatings
  class Rating < Sequel::Model
    dataset_module do
      def where_venue(venue_id)
        venue_ratings = SQL::VenueRatings.new(venue_id)

        where("id in (#{venue_ratings.sql})")
      end
    end
  end
end