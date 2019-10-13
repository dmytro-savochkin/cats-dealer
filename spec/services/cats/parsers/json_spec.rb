require 'rails_helper'

RSpec.describe Cats::Parsers::Json do
  describe '.call' do
    subject(:parsed_data) { described_class.call(json_data) }

    context 'when data is an empty object' do
      let(:json_data) { '{}' }

      it 'returns an empty hash' do
        expect(parsed_data).to eq({})
      end
    end

    context 'when data is a hash' do
      let(:json_data) { '{"name":"Abyssin"}' }

      it 'returns a hash' do
        expect(parsed_data).to eq('name' => 'Abyssin')
      end
    end

    context 'when data is a hash with null value' do
      let(:json_data) { '{"name": null}' }

      it 'returns a hash with nil value' do
        expect(parsed_data).to eq('name' => nil)
      end
    end

    context 'when data is an array with hash' do
      let(:json_data) { '[{"name":"Abyssin"}]' }

      it 'returns an array with a hash' do
        expect(parsed_data).to eq [{'name' => 'Abyssin'}]
      end
    end

    context 'when data is an array with two hashes' do
      let(:json_data) { '[{"name":"Abyssin"},{"name":"Nyan Cat"}]' }

      it 'returns an array with two hashes' do
        expect(parsed_data).to eq [{'name' => 'Abyssin'}, {'name' => 'Nyan Cat'}]
      end
    end
  end
end
