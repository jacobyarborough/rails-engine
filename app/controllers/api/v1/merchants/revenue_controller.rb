class Api::V1::Merchants::RevenueController < ApplicationController
  include Response
  include ExceptionHandler

  def index
    if params[:quantity] == nil || params[:quantity].to_i == 0 || params[:quantity] == ''
      message = {error: 'Error, incorrect query paramaters'}
      json_response(message, :bad_request)
    else 
      initial_merchants = Merchant.top_merchants_by_rev(params[:quantity].to_i)
      @processed_merchants = MerchantNameRevenueSerializer.new(initial_merchants)
      json_response(@processed_merchants)
    end
  end 
end 