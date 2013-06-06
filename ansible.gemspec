# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ansible/version'

Gem::Specification.new do |spec|
  spec.name          = "ansible"
  spec.version       = Ansible::VERSION
  spec.authors       = ["Derek Parker"]
  spec.email         = ["parkerderek86@gmail.com"]
  spec.description   = "Ansible allows you to stream events to a partial using ActionController::Live"
  spec.summary       = "Real time updates to browser using ActionController::Live"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails", "4.0.0.rc1"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rspec-spies"
end
