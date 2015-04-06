require 'snaptable/helpers/table'

module Snaptable
  class Railtie < Rails::Railtie
    initializer 'Snaptable.tables' do
      ActionController::Base.send :include, Helpers
    end
  end
end