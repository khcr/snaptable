require 'snaptable/engine'

module Snaptable
  @@use_permission = false
  @@add_button = true
  @@edit_button = true
  @@delete_button = true
  @@show_button = false

  mattr_accessor :use_permission, :add_button, :edit_button, :delete_button, :show_button
end