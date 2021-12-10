class Api::V1::Merchants::SearchController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_merchant

  def show
    json_response(@merchant)
  end
  
  private 

  def search_params
    params.permit(:name)
  end 

  def set_merchant
    @merchant = MerchantSerializer.new(Merchant.name_search(search_params[:name].downcase))
  end 
end 