shared_examples 'fetcher call with URL' do
  it 'calls fetcher with URL' do
    provide_cats
    expect(fetcher).to have_received(:call).with(described_class::URL)
  end
end

shared_examples 'parser call with raw data' do
  it 'calls parser with raw data' do
    provide_cats
    expect(parser).to have_received(:call).with(raw_data)
  end
end

shared_examples 'translator call with parsed data' do
  let(:expected_typecasting) { {name: :to_s, price: :to_i, location: :to_s, image: :to_s} }

  it 'calls translator with parsed data' do
    provide_cats
    expect(translator).to have_received(:call).with(data: parsed_data,
                                                    translation: expected_translation,
                                                    typecasting: expected_typecasting)
  end
end

shared_examples 'return of translated data' do
  it 'returns translated data' do
    expect(provide_cats).to eq translated_data
  end
end
