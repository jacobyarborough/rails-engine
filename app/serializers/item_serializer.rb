class ItemSerializer
  include JSONAPI::Serializer
  attributes :id, :description, :unit_price, :merchant_id
end
