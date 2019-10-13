module Cats
  module Providers
    class BaseProvider < BaseService
      TYPECASTING = {
        name: :to_s,
        price: :to_i,
        location: :to_s,
        image: :to_s
      }.freeze

      private_constant :TYPECASTING

      def initialize(fetcher: nil, parser: nil, translator: nil)
        raise NotImplementedError if self.class == BaseProvider

        @fetcher = fetcher || self.class::DEFAULT_FETCHER
        @parser = parser || self.class::DEFAULT_PARSER
        @translator = translator || self.class::DEFAULT_TRANSLATOR
      end

      def call
        response = fetcher.call(self.class::URL)
        parsed_response = parser.call(response)
        translator.call(data: parsed_response,
                        translation: self.class::TRANSLATION,
                        typecasting: TYPECASTING)
      end

      private

      attr_reader :fetcher, :parser, :translator
    end
  end
end
