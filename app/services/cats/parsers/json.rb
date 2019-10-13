module Cats
  module Parsers
    class Json < BaseService
      def initialize(data)
        @data = data
      end

      def call
        JSON.parse(data)
      end

      private

      attr_reader :data
    end
  end
end
