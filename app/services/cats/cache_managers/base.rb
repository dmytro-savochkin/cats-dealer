module Cats
  module CacheManagers
    class Base < BaseService
      EXPIRATION = 5.minutes

      private_constant :EXPIRATION

      def initialize(cache_suffix)
        @cache_suffix = cache_suffix
      end

      def call
        Rails.cache.fetch("cats_providers_#{cache_suffix}", expires_in: EXPIRATION) { yield }
      end

      private

      attr_reader :cache_suffix
    end
  end
end
