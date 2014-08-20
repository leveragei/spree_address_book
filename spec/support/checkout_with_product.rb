shared_context "checkout with product" do
  before :each do
    @state    = Spree::State.all.first || create(:state)
    @zone     = Spree::Zone.find_by_name('GlobalZone') || create(:global_zone)
    @shipping = Spree::ShippingMethod.find_by_name('UPS Ground') || create(:shipping_method)

    create(:check_payment_method)
    reset_spree_preferences do |config|
      config.company                    = true
      config.alternative_billing_phone  = true
      config.alternative_shipping_phone = true
    end

    visit spree.root_path
    click_link 'Ruby on Rails Mug'
    click_button 'add-to-cart-button'
  end

  let(:state) { @state }

  private
  def should_have_address_fields
    expect(page).to have_field("First Name")
    expect(page).to have_field("Last Name")
    expect(page).to have_field(I18n.t('activerecord.attributes.spree/address.address1'))
    expect(page).to have_field("City")
    expect(page).to have_field("Country")
    expect(page).to have_field(Spree.t(:zip))
    expect(page).to have_field(Spree.t(:phone))
  end

  def complete_checkout
    click_button Spree.t(:save_and_continue)
    choose "UPS Ground"
    click_button Spree.t(:save_and_continue)
    choose "Check"
    click_button Spree.t(:save_and_continue)
  end

  def fill_in_address(address, type = :bill)
    fill_in Spree.t(:first_name), with: address.firstname
    fill_in "Last Name", with: address.lastname
    fill_in "Company", with: address.company if Spree::Config[:company]
    fill_in I18n.t('activerecord.attributes.spree/address.address1'), with: address.address1
    fill_in I18n.t('activerecord.attributes.spree/address.address2'), with: address.address2
    select address.state.name, from: "order_#{type}_address_attributes_state_id"
    fill_in Spree.t(:city), with: address.city
    fill_in Spree.t(:zip), with: address.zipcode
    fill_in Spree.t(:phone), with: address.phone
    fill_in 'Alternative phone', with: address.alternative_phone if Spree::Config[:alternative_billing_phone]
  end

  def expected_address_format(address)
    a = address
    ("#{a.firstname} #{a.lastname} #{a.company} #{a.address1} #{a.address2} #{a.city} #{a.state.abbr} #{a.zipcode} #{a.country}".html_safe)
  end
end
