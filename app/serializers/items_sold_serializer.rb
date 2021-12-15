class ItemsSoldSerializer
  include JSONAPI::Serializer
  attributes :name

  attributes :count do |object|
    object.num
  end 
end