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

  def total
    initial_revenue = Merchant.total_rev_by_date(params[:start], params[:end])
    @processed_revenue = RevenueSerializer.new(initial_revenue[0])
    json_response(@processed_revenue)
  end 

  def show
    initial_merchant = Merchant.merchant_rev(params[:id].to_i)
    @processed_merchant = MerchantRevenueSerializer.new(initial_merchant[0])
    json_response(@processed_merchant)
  end 
end 