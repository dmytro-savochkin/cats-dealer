require 'rails_helper'

RSpec.describe CatsHelper, type: :helper do
  describe '#cat_unique_keys' do
    subject(:cat_unique_keys) { helper.cat_unique_keys(cats, key) }

    let(:key) { :location }

    context 'when cats are empty' do
      let(:cats) { [] }

      it 'returns empty result' do
        expect(cat_unique_keys).to be_blank
      end
    end

    context 'when there is one cat' do
      let(:cats) { [{location: 'Lviv', name: 'Cat 1'}] }
      let(:key) { :location }

      it 'returns one location' do
        expect(cat_unique_keys).to eq ['Lviv']
      end
    end

    context 'when there are two cats in different locations' do
      let(:cats) { [{location: 'Lviv', name: 'Cat 1'}, {location: 'Kyiv', name: 'Cat 2'}] }
      let(:key) { :location }

      it 'returns two locations' do
        expect(cat_unique_keys).to contain_exactly 'Lviv', 'Kyiv'
      end
    end

    context 'when there are two cats in same locations' do
      let(:cats) { [{location: 'Lviv', name: 'Cat 1'}, {location: 'Lviv', name: 'Cat 2'}] }
      let(:key) { :location }

      it 'returns one location' do
        expect(cat_unique_keys).to eq ['Lviv']
      end
    end

    context 'when there are two cats in same locations written with spaces' do
      let(:cats) { [{location: 'Lviv ', name: 'Cat 1'}, {location: ' Lviv', name: 'Cat 2'}] }

      it 'returns one location' do
        expect(cat_unique_keys).to eq ['Lviv']
      end
    end
  end
end
