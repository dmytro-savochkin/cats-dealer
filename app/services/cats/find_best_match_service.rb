module Cats
  class FindBestMatchService < BaseService
    def initialize(cats:, search_options:)
      @cats = cats
      @search_options = search_options
    end

    def call
      find_cheapest_cat(filter_cats(cats))
    end

    private

    attr_reader :cats, :search_options

    def filter_cats(cats)
      cats.select do |cat|
        cat[:location] == search_options[:location] &&
          cat[:name] == search_options[:name]
      end
    end

    def find_cheapest_cat(cats)
      cats.min_by { |cat| cat[:price] }
    end
  end
end
