module Cats
  class FetchAllService < BaseService
    def initialize(providers:, cache_manager:)
      @providers = providers
      @cache_manager = cache_manager
    end

    def call
      providers.reduce([]) do |result, provider|
        cache_manager.call(provider) do
          result + provider.call
        end
      end
    end

    private

    attr_reader :providers, :cache_manager
  end
end
