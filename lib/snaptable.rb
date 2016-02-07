require 'snaptable/engine'

module Snaptable
  @@use_permission = false
  @@add_button = true
  @@edit_button = true
  @@delete_button = true
  @@show_button = false

  mattr_accessor :use_permission, :add_button, :edit_button, :delete_button, :show_button

  def self.respond_with(controller, *args)
    if name = controller.params[:table]
      table = args.find { |table| table.table_name == name }
      table.respond
    end
  end

end
