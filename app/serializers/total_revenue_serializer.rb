class TotalRevenueSerializer
  include JSONAPI::Serializer
  attributes :revenue do |object|
    object.rev
  end 
end