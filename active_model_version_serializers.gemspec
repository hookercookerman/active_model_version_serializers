# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_model/version_serializers/version"

Gem::Specification.new do |gem|
  gem.name          = "active_model_version_serializers"
  gem.version       = ActiveModel::VersionSerializer::VERSION
  gem.authors       = ["hookercookerman"]
  gem.email         = ["hookercookerman@gmail.com"]
  gem.description   = %q{Active Model Serializer with versioning}
  gem.summary       = %q{Active Model Serializer with versioning}
  gem.homepage      = "http://thehitchhikerprinciple.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'active_model_serializers', '~>0.5.2'
  gem.add_dependency "activesupport", ">= 3.0.0"
  
  gem.add_development_dependency "rspec", "~> 2.11.0"
  gem.add_development_dependency "factory_girl", "~> 4.0.0"
  gem.add_development_dependency "fuubar", "~> 1.0.0"
  gem.add_development_dependency "activemodel", "~> 3.2.8"
end
