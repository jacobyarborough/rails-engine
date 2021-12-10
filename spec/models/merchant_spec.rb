require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:invoices) }
  it { should have_many(:items) }

  it { should validate_presence_of(:name) }

  before(:each) do 
    @merchant1 = Merchant.create!(name: 'ABC corp')
    @merchant2 = Merchant.create!(name: 'CAB Corp')
  end 

  describe 'class methods' do
    describe '.name_search' do
      it 'returns a merchant based on a name query param' do
        expect(Merchant.name_search('corp')).to eq([@merchant1])
      end 
    end 
  end 
end 