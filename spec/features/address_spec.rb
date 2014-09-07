require 'rails_helper'

describe 'Addresses', type: :feature, js: true do
  context 'editing' do
    include_context "user with address"
    include_context "address helpers"

    let!(:new_address) { create(:address) }

    before(:each) do
      visit spree.root_path
      click_link Spree.t(:login)
      sign_in_as!(user)
      click_link Spree.t(:my_account)
    end

    it 'is be able to create an address' do
      expect(page).to have_content(Spree.t("address_book.shipping_addresses"))
      click_link Spree.t("address_book.add_new_shipping_address")
      expect(page).to have_content(Spree.t("address_book.new_shipping_address"))
      fill_in_address(new_address, :account)
      click_on "Save"
      expect(page).to have_content(new_address.address1)
    end

    it "is able to update an existing address" do
      allow_any_instance_of(Spree::Address).to receive_messages(:editable? => false)

      within "#user_addresses" do
        click_on "Edit"
      end
      fill_in_address(new_address, :account)
      fill_in Spree.t(:first_name), with: "Nima"
      click_on "Update"
      expect(page).to have_content("Nima")
    end
  end

end
