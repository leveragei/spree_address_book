require 'rails_helper'

describe 'Addresses', type: :feature do
  context 'editing' do
    include_context "user with address"

    it 'is be able to edit an address', js: true do
      visit spree.root_path

      click_link Spree.t(:login)
      sign_in_as!(user)
      click_link Spree.t(:my_account)

      expect(page).to have_content(Spree.t("address_book.shipping_addresses"))

      click_link Spree.t("address_book.add_new_shipping_address")
      expect(page).to have_content(Spree.t("address_book.new_shipping_address"))
    end
  end

end
