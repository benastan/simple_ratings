require 'simple_ratings/rating'

module SimpleRatings
  class Foursquare < Faraday::Connection
    module Meta
      class Venue < Struct.new(:venue_id, :user_id)
        def ratings
          SimpleRatings::Rating.where_venue(venue_id)
        end

        def user_rating
          ratings.where(user_id: user_id).first
        end

        def to_json(options = nil)
          json = {
            userRating: user_rating,
            ratings: ratings,
            averageRating: ratings.avg(:stars).to_i
          }

          if ! user_rating.nil?
            json.merge!(
              oneStar: user_rating.stars == 1,
              twoStars: user_rating.stars == 2,
              threeStars: user_rating.stars == 3,
              fourStars: user_rating.stars == 4,
              fiveStars: user_rating.stars == 5
            )
          end

          JSON.dump(json)
        end
      end
    end
  end
end