class VehicleSerializer < ActiveModel::Serializer
  attributes :colour, :wheels
end

class CarSerializer < ActiveModel::VersionSerializer
  version :v1, VehicleSerializer do
    attributes :audio_system
  end

  version :v2 do
    version_attributes :v1, without: [:colour]
  end
end

