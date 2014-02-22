require 'sequel'

module SimpleRatings
  Sequel::Model.plugin :json_serializer

  Sequel::Model.plugin :timestamps

  Database = Sequel.connect(ENV['DATABASE_URL'])
end