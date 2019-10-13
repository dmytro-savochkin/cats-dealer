module Cats
  module Translators
    class Base < BaseService
      def initialize(data:, translation:, typecasting:)
        @data = data
        @translation = translation
        @typecasting = typecasting
      end

      def call
        data.map do |encoded_entity|
          decoded_entity = HashWithIndifferentAccess.new
          encoded_entity.keys.each do |key|
            new_key = translation[key.to_sym]
            new_type = typecasting[new_key]
            next if new_key.nil? || new_type.nil?

            decoded_entity[new_key] = encoded_entity[key].public_send(new_type)
          end
          decoded_entity
        end
      end

      private

      attr_reader :data, :translation, :typecasting
    end
  end
end
