module Cats
  module Providers
    class HappyCatsProvider < BaseProvider
      URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'.freeze
      TRANSLATION = {
        title: :name,
        cost: :price,
        location: :location,
        img: :image
      }.freeze
      DEFAULT_FETCHER = Cats::Fetchers::HttpGet
      DEFAULT_PARSER = Cats::Parsers::Xml
      DEFAULT_TRANSLATOR = Cats::Translators::Base
    end
  end
end
