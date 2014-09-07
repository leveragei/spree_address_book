shared_context "checkout with product" do
  include_context "address helpers"

  before :each do
    @state    = Spree::State.all.first || create(:state)
    @zone     = Spree::Zone.find_by(name: 'GlobalZone') || create(:global_zone)
    @shipping = Spree::ShippingMethod.find_by(name: 'UPS Ground') || create(:shipping_method)

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
end
