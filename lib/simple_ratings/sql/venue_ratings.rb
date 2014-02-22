module SimpleRatings
  module SQL
    class VenueRatings < Struct.new(:venue_id) 
      def sql
        <<-SQL
SELECT id
FROM (#{latest_ratings_sql}) latest_ratings
#{ratings_join_statement}
SQL
      end

      def latest_ratings_sql
        <<-SQL
  SELECT MAX(created_at)
  AS max_created_at, user_id
  FROM ratings
  WHERE venue_id = '#{venue_id}'
  GROUP BY user_id
  SQL
      end

      def ratings_join_statement
        <<-SQL
  INNER JOIN ratings
  ON latest_ratings.user_id = ratings.user_id
  AND latest_ratings.max_created_at = ratings.created_at
  AND ratings.venue_id = '#{venue_id}'
  SQL
      end
    end
  end
end