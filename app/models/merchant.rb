class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  
  validates_presence_of :name

  def self.name_search(name_string)
    where("lower(merchants.name) like '#{'%' + name_string + '%'}'").order(name: :asc).limit(1)[0]
  end
end 