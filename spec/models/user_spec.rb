require 'rails_helper'

describe Spree::User, type: :model do
  let(:user)    { create(:user) }
  let(:address) { create(:address) }
  let(:address2) { create(:address) }
  before {
    address.user = user
    address.save
    address2.user = user
    address2.save
  }

  describe 'user has_many addresses' do
    it 'should have many addresses' do
      expect(user).to respond_to(:addresses)
      expect(user.addresses).to eq([address2, address])
    end
  end
end
