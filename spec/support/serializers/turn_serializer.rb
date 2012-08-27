class TurnSerializer < ActiveModel::VersionSerializer

  version :v1 do
    attributes :id, :name, :score
  end

  version :v2 do
    version_attributes :v1, without: :score
  end

  version :v3 do
    version_attributes :v1, with: :image
  end

end
