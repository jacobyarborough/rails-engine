class Api::V1::Items::SearchController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :get_items

  def index
    if params[:name] && (params[:min_price] || params[:max_price])
      json_response(@items, :not_found)
    else 
      json_response(@items)
    end
  end
  
  private 

  def search_params
    params.permit(:name, :min_price, :max_price)
  end 

  def get_items
    if params[:name] && (params[:min_price] || params[:max_price])
      @items = {message: 'Error, can not search by name and price at once'}
    else 
      @items = ItemSerializer.new(Item.item_search(search_params))
    end
  end 
end 