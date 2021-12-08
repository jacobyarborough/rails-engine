class Api::V1::MerchantsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_merchant, only: [:show, :update, :destroy]

  def index
    @merchants = MerchantSerializer.new(Merchant.all)
    json_response(@merchants)
  end

  private 

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end 
end
