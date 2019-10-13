module Cats
  module Parsers
    class Xml < BaseService
      def initialize(data)
        @data = data
      end

      # TODO: This can be refactored a bit but no time for this right now.
      def call
        with_outer_tag = Hash.from_xml(data)
        with_inner_tag = with_outer_tag&.values&.first
        without_inner_tag = with_inner_tag&.values&.first&.compact || []
        without_inner_tag = [without_inner_tag] if without_inner_tag.is_a?(Hash)
        without_inner_tag
      end

      private

      attr_reader :data
    end
  end
end
