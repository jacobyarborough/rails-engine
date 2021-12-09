class Api::V1::Items::MerchantsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_item, only: [:show]

  def show
    json_response(@items)
  end 

  private 

  def set_item
    item = Item.find(params[:id])
    @items = MerchantSerializer.new(item.merchant)
  end 
end 