require 'rails_helper'

describe Spree::Address, type: :model do

  # Test spree_address_book's address_decorator.rb.
  describe 'spree_address_book address_decorator' do
    let(:address)  { create(:address) }
    let(:address2) { create(:address) }
    let(:order)    { create(:completed_order_with_totals) }
    let(:user)     { create(:user) }

    before do
      order.bill_address = address2
      order.save
    end

    it 'has required attributes' do
      expect(Spree::Address.required_fields).to eq([:firstname, :lastname, :address1, :city, :country])
    end

    it 'is editable' do
      expect(address).to be_editable
    end

    it 'can be deleted' do
      expect(address).to be_can_be_deleted
    end

    it "isn't editable when there is an associated order" do
      expect(address2).not_to be_editable
    end

    it "can't be deleted when there is an associated order" do
      expect(address2).not_to be_can_be_deleted
    end

    it 'is displayed as string' do
      a = address
      expect(address.to_s).to eq("#{a.firstname} #{a.lastname}: #{a.address1}, #{a.address2}, #{a.city}, #{a.state || a.state_name}, #{a.country}, #{a.zipcode}".html_safe)
    end

    it 'is destroyed without saving used' do
      address.destroy
      expect(Spree::Address.where(id: address.id)).to be_empty
    end

    it 'is destroyed deleted timestamp' do
      address2.destroy
      expect(Spree::Address.where(id: address2.id)).to_not be_empty
    end
  end

end
