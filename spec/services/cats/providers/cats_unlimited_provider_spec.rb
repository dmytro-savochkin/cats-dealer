require 'rails_helper'
require 'services/cats/providers/shared_examples'

RSpec.describe Cats::Providers::CatsUnlimitedProvider do
  describe '.call' do
    subject(:provide_cats) do
      described_class.call(fetcher: fetcher, parser: parser, translator: translator)
    end

    let(:fetcher) { double(call: raw_data) }
    let(:parser) { double(call: parsed_data) }
    let(:translator) { double(call: translated_data) }
    let(:raw_data) { '[{"title":"Nyan Cat"}]' }
    let(:parsed_data) { [{title: 'Nyan Cat'}] }
    let(:translated_data) { [{name: 'Nyan Cat'}] }
    let(:expected_translation) do
      {name: :name, price: :price, location: :location, image: :image}
    end

    include_examples 'fetcher call with URL'
    include_examples 'parser call with raw data'
    include_examples 'translator call with parsed data'
    include_examples 'return of translated data'
  end
end
