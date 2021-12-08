class Api::V1::MerchantsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_merchant, only: [:show, :update, :destroy]

  def index
    @merchants = MerchantSerializer.new(Merchant.all)
    json_response(@merchants)
  end

  def show
    json_response(@merchant)
  end 

  private 

  def set_merchant
    @merchant = MerchantSerializer.new(Merchant.find(params[:id]))
  end 
end
