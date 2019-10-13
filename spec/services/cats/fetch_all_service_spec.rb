require 'rails_helper'

RSpec.describe Cats::FetchAllService do
  describe '.call' do
    subject(:fetch_all_cats) do
      described_class.call(providers: providers, cache_manager: cache_manager)
    end

    let(:providers) do
      [
        double(call: [{title: 'Nyan Cat'}]),
        double(call: [{title: 'SuperCat'}])
      ]
    end
    let(:cache_manager) { double }

    before { allow(cache_manager).to receive(:call).and_yield }

    it 'returns cats from both providers' do
      expect(fetch_all_cats).to eq [{title: 'Nyan Cat'}, {title: 'SuperCat'}]
    end
  end
end
