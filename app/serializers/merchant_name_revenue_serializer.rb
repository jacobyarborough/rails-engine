class MerchantNameRevenueSerializer
  include JSONAPI::Serializer
  attributes :name

  attributes :revenue do |object|
    object.rev
  end 
end
