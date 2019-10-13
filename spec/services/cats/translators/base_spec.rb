require 'rails_helper'

RSpec.describe Cats::Translators::Base do
  describe '.call' do
    subject(:translated_data) do
      described_class.call(data: data, translation: translation, typecasting: typecasting)
    end

    let(:typecasting) { {name: :to_s, price: :to_i, location: :to_s, image: :to_s} }

    shared_examples 'correctly translated data' do
      it 'returns correctly translated data' do
        expect(translated_data).to match_array expected_array
      end
    end

    context 'when data, translator, and typecasting is for HappyCatsProvider' do
      let(:data) do
        [
          {'title' => 'Nyan Cat', 'cost' => '100', 'location' => 'Lviv', 'img' => 'file.gif'},
          {title: 'SuperCat', cost: 200, location: 'Odesa', img: 'file.jpg'}
        ]
      end
      let(:translation) { {title: :name, cost: :price, location: :location, img: :image} }
      let(:expected_array) do
        [
          {name: 'Nyan Cat', price: 100, location: 'Lviv', image: 'file.gif'},
          {name: 'SuperCat', price: 200, location: 'Odesa', image: 'file.jpg'}
        ]
      end

      include_examples 'correctly translated data'
    end

    context 'when data, translator, and typecasting is for CatsUnlimitedProvider' do
      let(:data) do
        [
          {'name' => 'Cat', 'price' => '100', 'location' => 'Lviv', 'image' => 'file.gif'},
          {name: 'SuperCat', price: 200, location: 'Odesa', image: 'file.jpg'}
        ]
      end
      let(:translation) { {name: :name, price: :price, location: :location, image: :image} }
      let(:expected_array) do
        [
          {name: 'Cat', price: 100, location: 'Lviv', image: 'file.gif'},
          {name: 'SuperCat', price: 200, location: 'Odesa', image: 'file.jpg'}
        ]
      end

      include_examples 'correctly translated data'
    end
  end
end
