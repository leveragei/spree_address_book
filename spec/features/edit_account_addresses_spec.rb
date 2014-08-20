require 'rails_helper'

describe "User editing addresses for his account", type: :feature do
  stub_authorization!

  include_context "user with address"

  before(:each) do
    sign_in_as!(user)
    click_link "My Account"
  end

  it " see list of addresses saved for account" do
    expect(page).to have_content("Addresses")
    expect(page).to have_selector("#user_addresses > tbody > tr", count: user.addresses.count)
  end

  it " be able to add address" do

  end

  it " be able to edit address", js: true do
    page.evaluate_script('window.confirm = function() { return true; }')

    within(:xpath, '//*[@id="user_addresses"]/tbody/tr/td[2]') do
      click_link Spree.t(:edit)
    end
    expect(current_path).to eq(spree.edit_address_path(address))

    new_street = Faker::Address.street_address
    fill_in I18n.t('activerecord.attributes.spree/address.address1'), with: new_street
    click_button "Update"
    expect(page).to have_content('Address has been successfully updated!')
    expect(current_path).to eq(spree.account_path)

    within(:xpath, '//*[@id="user_addresses"]/tbody/tr') do
      expect(page).to have_content(new_street)
    end
  end

  it "is be able to remove address", js: true do
    # bypass confirm dialog
    page.evaluate_script('window.confirm = function() { return true; }')
    within(:xpath, '//*[@id="user_addresses"]/tbody/tr') do
      click_link Spree.t(:remove)
    end
    expect(current_path).to eq(spree.account_path)

    # flash message
    expect(page).to have_content("removed")

    # header still exists for the area - even if it is blank
    expect(page).to have_content("Addresses")

    # table is not displayed unless addresses are available
    expect(page).not_to have_selector("#user_addresses")
  end
end
