require 'rails_helper'

RSpec.describe Cats::Fetchers::HttpGet do
  describe '.call' do
    subject(:response) { described_class.call(url) }

    let(:url) { 'http://ip.jsontest.com/' }

    it 'returns a string from the provided url' do
      VCR.use_cassette("#{described_class}-#{url}") do
        expect(response).to eq '{"ip": "93.77.129.68"}'
      end
    end
  end
end
