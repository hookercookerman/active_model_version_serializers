class Car
  include ActiveModel::SerializerSupport
  attr_accessor :audio_system, :colour, :wheels
end
