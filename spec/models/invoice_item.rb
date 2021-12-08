require 'rails_helper'

RSpec.describe Invoice, type: :model do 
  it { should belong_to(:invoice) }
  it { should belong_to(:item) }

  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit_price) }
end 