require 'faraday'
require 'simple_ratings/foursquare/meta/venue'

module SimpleRatings
  class Foursquare < Faraday::Connection
    def initialize
      super(url: 'https://api.foursquare.com/v2/')
    end

    def default_params
      {
        client_id: ENV['FOURSQUARE_CLIENT_ID'],
        client_secret: ENV['FOURSQUARE_CLIENT_SECRET'],
        v: 20130214
      }
    end

    def search(params)
      get('venues/search', default_params.merge(params))
    end

    def get(url = nil, params = nil, headers = nil)
      params ||= {}

      params = default_params.merge(params)

      super(url, params, headers)
    end

    # def get(*args)
    #   super(*build_default_request_arguments(*args))
    # end

    # def build_default_request_arguments(url = nil, params = nil, headers = nil)
    #   params ||= {}

    #   params = default_params.merge(params)

    #   [url, params, headers]
    # end
  end
end