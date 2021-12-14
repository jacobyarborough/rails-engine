class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  
  validates_presence_of :name

  def self.name_search(name_string)
    where("lower(merchants.name) like '#{'%' + name_string + '%'}'").order(name: :asc).limit(1)[0]
  end

  def self.top_merchants_by_rev(quantity)
    joins(invoices: [:transactions, :invoice_items])
    .where(invoices: {status: 'shipped'}, transactions: {result: 'success'})
    .group(:id)
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as rev')
    .order('rev desc')
    .limit(quantity)
  end 
end 