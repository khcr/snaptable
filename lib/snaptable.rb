require 'snaptable/version'
require 'snaptable/railtie' if defined?(Rails)
require 'snaptable/rails'

module Snaptable
  @@use_permission = false

  mattr_accessor :use_permission
end