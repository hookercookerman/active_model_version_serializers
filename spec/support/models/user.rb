class User
  include ActiveModel::SerializerSupport
  attr_accessor :name, :date_of_birth, :likes_eggs, :likes_beans, :remote_image, :turns, :id
end
