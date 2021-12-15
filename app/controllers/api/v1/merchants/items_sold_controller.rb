class Api::V1::Merchants::ItemsSoldController < ApplicationController
  include Response
  include ExceptionHandler

  def index
    if params[:quantity] == nil || params[:quantity].to_i == 0
      message = {error: 'Error, incorrect query paramaters'}
      json_response(message, :bad_request)
    elsif params[:quantity] == ''
      initial_merchants = Merchant.top_merchants_by_items_sold(5)
      @processed_merchants = ItemsSoldSerializer.new(initial_merchants)
      json_response(@processed_merchants)
    else 
      initial_merchants = Merchant.top_merchants_by_items_sold(params[:quantity].to_i)
      @processed_merchants = ItemsSoldSerializer.new(initial_merchants)
      json_response(@processed_merchants)
    end
  end 
end 