# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'select_options/version'

Gem::Specification.new do |spec|
  spec.name          = "select-options"
  spec.version       = SelectOptions::VERSION
  spec.authors       = ["Jonas"]
  spec.email         = ["jonas@launchd.de"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = "https://github.com/jonas-d/select-options"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "1.3.5"
  spec.add_development_dependency "rake", "10.1.0"
  spec.add_development_dependency "activerecord", "3.2.8"
  spec.add_development_dependency "actionpack", "3.2.8"  # required for action_view
  spec.add_development_dependency "sqlite3", "1.3.8"
  spec.add_development_dependency "rspec", "2.14.1"
  spec.add_development_dependency "database_cleaner", "0.9.1"
  spec.add_development_dependency "xml-simple"
end


# Description
# a) setup has_one :through polymorphic association to STI model:
#    has_one :association_model
#    has_one :attr_name, :through => :association_model, :source_type => "STIBaseClass"
# b) setup has_one :through polymorphic association to models of different types
#    has_one :association_model, :as => :...
#    has_one :attr_name, :through => :association_model