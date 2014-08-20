require 'rails_helper'

describe 'spree/addresses/new', type: :view do
  let(:address) { build(:address) }

  it 'renders new.html.erb for new address' do
    assign(:address, address)
    render template: 'spree/addresses/new', address: address

    expect(rendered).to have_content('New Shipping Address')
    expect(rendered).to have_field("address_firstname")
    expect(rendered).to have_field("address_lastname")
    expect(rendered).to have_field("address_address1")
    expect(rendered).to have_field("address_address2")
    # Javascript can't be tested in views spec
    expect(rendered).to have_selector('select#address_country_id')
    # Javascript can't be tested in views spec
    expect(rendered).to have_selector('#address_state_name')
    expect(rendered).to have_field('address_city')
    expect(rendered).to have_field('address_zipcode')
    expect(rendered).to have_field('address_phone')
  end

end

describe 'spree/addresses/edit', type: :view do
  let(:address) { create(:address) }

  it 'renders edit.html.erb for editing an existing address' do
    assign(:address, address)
    render template: 'spree/addresses/edit', address: address

    expect(rendered).to have_field("address_firstname", with: address.firstname)
    expect(rendered).to have_field("address_lastname", with: address.lastname)
    expect(rendered).to have_field("address_address1", with: address.address1)
    expect(rendered).to have_field("address_address2", with: address.address2)
    # # Javascript can't be tested in views spec
    expect(rendered).to have_selector('select#address_country_id')
    # # Javascript can't be tested in views spec
    expect(rendered).to have_selector('#address_state_name')
    expect(rendered).to have_field('address_city', with: address.city)
    expect(rendered).to have_field('address_zipcode', with: address.zipcode)
    expect(rendered).to have_field('address_phone', with: address.phone)
  end
end


# a few methods to deal with problems in the views, due to the usage of form_for @address.
def address_path(address, format)
  spree.address_path(address, format)
end

def addresses_path(format)
  spree.addresses_path(format)
end

# I'm not sure why this method isn't available, or how to make it available, so
# I've cloned it from Spree::BaseHelper.
def available_countries
  countries = Spree::Zone.find_by_name(Spree::Config[:checkout_zone]).try(:country_list) || Spree::Country.all
  countries.collect do |c|
    c.name = t(c.name, scope: 'countries', default: c.name)
    c
  end.sort { |a, b| a.name <=> b.name }
end
