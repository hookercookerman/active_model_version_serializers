class UserSerializer < ActiveModel::VersionSerializer

  version :v1 do
    attributes :name, :remote_image, :likes_beans, :id
  end

  version :v2 do
    version_attributes :v1, without: [:likes_beans, :remote_image]
  end

  version :v3 do
    version_attributes :v1, with: :date_of_birth
    embed :ids, :include => true
    has_many :turns
  end
end

