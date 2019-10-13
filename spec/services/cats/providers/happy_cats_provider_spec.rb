require 'rails_helper'

RSpec.describe Cats::Providers::HappyCatsProvider do
  describe '.call' do
    subject(:provide_cats) do
      described_class.call(fetcher: fetcher, parser: parser, translator: translator)
    end

    let(:fetcher) { double(call: raw_data) }
    let(:parser) { double(call: parsed_data) }
    let(:translator) { double(call: translated_data) }
    let(:raw_data) { '<cats><cat><title>Nyan Cat</title></cat></cats>' }
    let(:parsed_data) { [{title: 'Nyan Cat'}] }
    let(:translated_data) { [{name: 'Nyan Cat'}] }
    let(:expected_translation) do
      {title: :name, cost: :price, location: :location, img: :image}
    end

    include_examples 'fetcher call with URL'
    include_examples 'parser call with raw data'
    include_examples 'translator call with parsed data'
    include_examples 'return of translated data'
  end
end
