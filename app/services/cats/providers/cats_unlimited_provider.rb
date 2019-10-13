module Cats
  module Providers
    class CatsUnlimitedProvider < BaseProvider
      URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'.freeze
      TRANSLATION = {
        name: :name,
        price: :price,
        location: :location,
        image: :image
      }.freeze
      DEFAULT_FETCHER = Cats::Fetchers::HttpGet
      DEFAULT_PARSER = Cats::Parsers::Json
      DEFAULT_TRANSLATOR = Cats::Translators::Base
    end
  end
end
