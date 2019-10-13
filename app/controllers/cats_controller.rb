class CatsController < ApplicationController
  PROVIDERS = [Cats::Providers::HappyCatsProvider,
               Cats::Providers::CatsUnlimitedProvider].freeze
  FETCHER = Cats::FetchAllService
  CACHE_MANAGER = Cats::CacheManagers::Base

  private_constant :PROVIDERS, :FETCHER, :CACHE_MANAGER

  def index
    @resources = aggregated_cats
  end

  def best_deal
    @resource = Cats::FindBestMatchService.call(
      cats: aggregated_cats,
      search_options: {location: params[:location], name: params[:name]}
    )
  end

  private

  def aggregated_cats
    FETCHER.call(providers: PROVIDERS, cache_manager: CACHE_MANAGER)
  end
end
