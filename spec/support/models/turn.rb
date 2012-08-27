class Turn
  include ActiveModel::SerializerSupport
  attr_accessor :name, :score, :image, :id
end
