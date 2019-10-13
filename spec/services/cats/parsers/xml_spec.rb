require 'rails_helper'

RSpec.describe Cats::Parsers::Xml do
  describe '.call' do
    subject(:parsed_data) { described_class.call(xml_data) }

    context 'when data is an empty string' do
      let(:xml_data) { '' }

      it 'returns an empty array' do
        expect(parsed_data).to eq []
      end
    end

    context 'when data is an empty b tag' do
      let(:xml_data) { '<b></b>' }

      it 'returns an empty array' do
        expect(parsed_data).to eq []
      end
    end

    context 'when data is an empty cats tag' do
      let(:xml_data) { '<cats></cats>' }

      it 'returns an empty array' do
        expect(parsed_data).to eq []
      end
    end

    context 'when data is an array of one empty cat tag inside a cats tag' do
      let(:xml_data) { '<cats><cat></cat></cats>' }

      it 'returns an empty array' do
        expect(parsed_data).to eq []
      end
    end

    context 'when data is an array of two empty cat tags inside a cats tag' do
      let(:xml_data) { '<cats><cat></cat><cat></cat></cats>' }

      it 'returns an empty array' do
        expect(parsed_data).to eq []
      end
    end

    context 'when data is an array of one cat tag inside a cats tag' do
      let(:xml_data) do
        '<cats><cat><title>American Cat</title></cat></cats>'
      end

      it 'returns an array with a hash' do
        expect(parsed_data).to eq [{'title' => 'American Cat'}]
      end
    end

    context 'when data is an array of two cat tags inside a cats tag' do
      let(:xml_data) do
        '<cats><cat><title>American Cat</title></cat><cat><title>Nyan Cat</title></cat></cats>'
      end

      it 'returns an array with two hashes' do
        expect(parsed_data).to eq [{'title' => 'American Cat'}, {'title' => 'Nyan Cat'}]
      end
    end

    context 'when data is an array of two cat tags inside a cats tag with a leading xml tag' do
      let(:xml_data) do
        '<?xml version="1.0" encoding="UTF-8"?>' \
        '<cats><cat><title>American Cat</title></cat><cat><title>Nyan Cat</title></cat></cats>'
      end

      it 'returns an array with two hashes' do
        expect(parsed_data).to eq [{'title' => 'American Cat'}, {'title' => 'Nyan Cat'}]
      end
    end
  end
end
