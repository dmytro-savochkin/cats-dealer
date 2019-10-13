require 'rails_helper'

RSpec.describe Cats::CacheManagers::Base do
  describe '.call' do
    subject(:cache_data) { described_class.call(cache_suffix) { cached_data } }

    let(:cache_suffix) { 'SomeClassName' }
    let(:cached_data) { 'some-string' }

    before { cache_data }

    it 'saves the data in the cache' do
      expect(Rails.cache.read("cats_providers_#{cache_suffix}")).to eq cached_data
    end
  end
end
