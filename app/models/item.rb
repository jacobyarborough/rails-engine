class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def self.item_search(params)
    if params[:name]
      where("lower(items.name) like '#{'%' + params[:name].downcase + '%'}'")
    elsif params[:min_price] && params[:max_price]
      where("items.unit_price between #{params[:min_price]} and #{params[:max_price]}")
    elsif params[:min_price]
      where("items.unit_price >= #{params[:min_price]}")
    elsif params[:max_price]
      where("items.unit_price <= #{params[:max_price]}")
    end 
  end
end 