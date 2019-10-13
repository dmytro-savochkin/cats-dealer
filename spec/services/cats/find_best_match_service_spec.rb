require 'rails_helper'

RSpec.describe Cats::FindBestMatchService do
  describe '.call' do
    subject(:fetch_best_match) do
      described_class.call(cats: cats, search_options: search_options)
    end

    shared_examples 'nil response' do
      it 'returns nil' do
        expect(fetch_best_match).to be_nil
      end
    end

    shared_examples 'cat response' do
      it 'returns the cheapest cat' do
        expect(fetch_best_match).to eq expected_cat
      end
    end

    context 'when no cats passed' do
      let(:cats) { [] }
      let(:search_options) { {location: 'Odesa', name: 'Cat'} }

      include_examples 'nil response'
    end

    context 'when one non-applicable cat is passed' do
      let(:cats) { [{location: 'Lviv', name: 'Cat', price: 100}] }
      let(:search_options) { {location: 'Odesa', name: 'Cat'} }

      include_examples 'nil response'
    end

    context 'when two non-applicable cats are passed' do
      let(:cats) do
        [
          {location: 'Lviv', name: 'Cat', price: 100},
          {location: 'Odesa', name: 'Kitty', price: 100}
        ]
      end
      let(:search_options) { {location: 'Odesa', name: 'Cat'} }

      include_examples 'nil response'
    end

    context 'when one applicable cat is passed' do
      let(:cats) { [expected_cat] }
      let(:expected_cat) { {location: 'Odesa', name: 'Cat', price: 100} }
      let(:search_options) { {location: 'Odesa', name: 'Cat'} }

      include_examples 'cat response'
    end

    context 'when one applicable and one non-applicable cats are passed' do
      let(:cats) { [expected_cat, another_cat] }
      let(:expected_cat) { {location: 'Odesa', name: 'Cat', price: 100} }
      let(:another_cat) { {location: 'Lviv', name: 'Kitty', price: 100} }
      let(:search_options) { {location: 'Odesa', name: 'Cat'} }

      include_examples 'cat response'
    end

    context 'when two applicable cats are passed' do
      let(:cats) { [expected_cat, another_cat] }
      let(:expected_cat) { {location: 'Odesa', name: 'Cat', price: 100} }
      let(:another_cat) { {location: 'Odesa', name: 'Cat', price: 200} }
      let(:search_options) { {location: 'Odesa', name: 'Cat'} }

      include_examples 'cat response'
    end

    context 'when three applicable cats are passed' do
      let(:cats) { [expensive_cats[0], expected_cat, expensive_cats[1]] }
      let(:expected_cat) { {location: 'Odesa', name: 'Cat', price: 100} }
      let(:expensive_cats) do
        [
          {location: 'Odesa', name: 'Cat', price: 200},
          {location: 'Odesa', name: 'Cat', price: 250}
        ]
      end
      let(:search_options) { {location: 'Odesa', name: 'Cat'} }

      include_examples 'cat response'
    end
  end
end
