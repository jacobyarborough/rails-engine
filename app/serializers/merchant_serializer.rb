class MerchantSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  has_many :items
  has_many :invoices
end
