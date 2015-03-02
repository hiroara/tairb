# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tairb/version'

Gem::Specification.new do |spec|
  spec.name          = "tairb"
  spec.version       = Tairb::VERSION
  spec.authors       = ["Arai Hiroki"]
  spec.email         = ["hiroara62@gmail.com"]
  spec.summary       = %q{tairb is tiny tool to read file like as `tail -f`.}
  spec.description   = %q{tairb is tiny tool to read file like as `tail -f`.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
