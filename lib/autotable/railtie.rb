require 'autotable/table_constructor/table'

module Autotable
  class Railtie < Rails::Railtie
    initializer 'autotable.tables' do
      ActionController::Base.send :include, TableConstructor
    end
  end
end