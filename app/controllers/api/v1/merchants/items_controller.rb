class Api::V1::Merchants::ItemsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_merchant, only: [:index]

  def index
    json_response(@items)
  end 

  private 

  def set_merchant
    merchant = Merchant.find(params[:id])
    @items = ItemSerializer.new(merchant.items)
  end 
end 