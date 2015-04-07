# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snaptable/version'

Gem::Specification.new do |spec|
  spec.name          = "snaptable"
  spec.version       = Snaptable::VERSION
  spec.authors       = ["khcr"]
  spec.email         = ["kocher.ke@gmail.com"]

  spec.summary       = "A gem that generate HTML tables from your models in order to display them in your admin views."
  spec.description   = spec.summary
  spec.homepage      = "http://github.com/khcr/snaptable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "railties", ">= 4.2.0"
  spec.add_dependency "will_paginate", ">= 3.0.0"
end
