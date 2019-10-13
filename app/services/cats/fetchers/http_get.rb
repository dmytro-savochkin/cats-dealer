module Cats
  module Fetchers
    class HttpGet < BaseService
      def initialize(url)
        @url = url
      end

      def call
        RestClient.get(url)&.to_s&.strip
      end

      private

      attr_reader :url
    end
  end
end
