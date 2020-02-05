$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "snaptable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "snaptable"
  s.version     = Snaptable::VERSION
  s.authors     = ["khcr"]
  s.email       = ["kocher.ke@gmail.com"]
  s.homepage    = "http://github.com/khcr/snaptable"
  s.summary     = "A gem that generate HTML tables from your models in order to display them in your admin views."
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0"
  s.add_dependency "will_paginate"
  s.add_dependency "sassc-rails"

  s.add_development_dependency "sqlite3"
end
