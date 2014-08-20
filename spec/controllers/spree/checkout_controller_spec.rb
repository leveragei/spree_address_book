require 'rails_helper'

describe Spree::CheckoutController, type: :controller do

  before do
    user     = create(:user)
    @address = create(:address, user: user)

    @order = create(:order, bill_address_id: nil, ship_address_id: nil)
    @order.contents.add(create(:product).master, 1)
    @order.user         = user
    @order.ship_address = create(:address)
    @address.user       = @order.user
    @order.line_items << FactoryGirl.create(:line_item)
    @order.save

    allow(controller).to receive_messages current_order: @order
    allow(controller).to receive_messages current_user: user
    allow(controller).to receive_messages try_spree_current_user: user
    allow(controller).to receive_messages spree_current_user: user

    allow(@order).to receive_messages available_shipping_methods: [stub_model(Spree::ShippingMethod)]
    allow(@order).to receive_messages available_payment_methods: [stub_model(Spree::PaymentMethod)]
    allow(@order).to receive_messages ensure_available_shipping_rates: true
  end

  describe "on address step" do
    it "sets equal address ids" do
      put_address_to_order('bill_address_id' => @address.id, 'ship_address_id' => @address.id)
      expect(@order.bill_address).to be_present
      expect(@order.ship_address).to be_present
      expect(@order.bill_address_id).to eq(@address.id)
      expect(@order.bill_address_id).to eq(@order.ship_address_id)
    end

    it "sets bill_address_id and use_billing" do
      put_address_to_order(bill_address_id: @address.id, use_billing: true)
      expect(@order.bill_address).to be_present
      expect(@order.ship_address).to be_present
      expect(@order.bill_address_id).to eq(@address.id)
      expect(@order.bill_address_id).to eq(@order.ship_address_id)
    end

    it "sets address attributes" do
      # clone the unassigned address for easy creation of valid data
      # remove blacklisted attributes to avoid mass-assignment error
      cloned_attributes = @address.clone.attributes.select { |k, v| !['id', 'created_at', 'deleted_at', 'updated_at'].include? k }

      put_address_to_order(bill_address_attributes: cloned_attributes, ship_address_attributes: cloned_attributes)
      expect(@order.bill_address_id).not_to eq(nil)
      expect(@order.ship_address_id).not_to eq(nil)
      expect(@order.bill_address_id).to eq(@order.ship_address_id)
    end
  end

  private

  def put_address_to_order(params)
    spree_post :update, { state: "address", order: params }
  end

end
