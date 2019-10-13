require 'rails_helper'

# TODO: This should be rewritten to DRY it up regarding VCR and other things.
describe 'Cats Dealer', :aggregate_failures do
  vcr_cassette_name = 'acceptance-cats'

  def search_for_best_deal(name, location)
    find('#name').find("option[value='#{name}']").select_option
    find('#location').find("option[value='#{location}']").select_option
    find('.best-deal-form input[type="submit"]').click
  end

  def expect_to_have_records(count)
    expect(page).to have_selector('table.cats tbody tr', count: count)
    expect(page).not_to have_selector('table.cats tbody td:empty')
  end

  def expect_to_have_specific_record(name:, location:, price:)
    expect(page).to have_selector('table.cats tbody tr td.name', text: name)
    expect(page).to have_selector('table.cats tbody tr td.location', text: location)
    expect(page).to have_selector('table.cats tbody tr td.price', text: price)
  end

  def expect_not_to_have_records
    expect(page).not_to have_selector('table.cats')
  end

  it 'shows 21 records on index page' do
    VCR.use_cassette(vcr_cassette_name) do
      visit root_path
      expect_to_have_records(21)
    end
  end

  it 'finds the single best deal' do
    VCR.use_cassette(vcr_cassette_name) do
      visit root_path
      search_for_best_deal('Bengal', 'Kyiv')
      expect_to_have_specific_record(name: 'Bengal', location: 'Kyiv', price: 600)
    end
  end

  it 'does not find the best deal' do
    VCR.use_cassette(vcr_cassette_name) do
      visit root_path
      search_for_best_deal('Grumpy', 'Kharkiv')
      expect_not_to_have_records
    end
  end
end
