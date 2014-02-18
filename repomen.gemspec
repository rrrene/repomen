# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'repomen/version'

Gem::Specification.new do |spec|
  spec.name          = "repomen"
  spec.version       = Repomen::VERSION
  spec.authors       = ["René Föhring"]
  spec.email         = ["rf@bamaru.de"]
  spec.summary       = %q{Interface wrapper for retrieving repos}
  spec.description   = %q{Interface wrapper for retrieving repos from GitHub and BitBucket}
  spec.homepage      = "http://trivelop.de/repomen/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "minitest", "~> 5.2"
end
