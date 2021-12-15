class MerchantRevenueSerializer
  include JSONAPI::Serializer
  attributes :revenue do |object|
    object.rev.round(2)
  end 
end
