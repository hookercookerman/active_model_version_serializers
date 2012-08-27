require "rubygems"
require "bundler/setup"

unless ENV["TRAVIS"]
  require 'simplecov'
  SimpleCov.start do
    add_group "lib", "lib"
    add_group "spec", "spec"
  end
end

require "pry"
require "active_model_version_serializers"

Dir.glob(File.expand_path('../../spec/support/**/*.rb', __FILE__)) do |file|
  require file
end
