module Autotable
  class Railtie < Rails::Railtie
    initializer 'autotable.tables' do
      ActionController::Base.send :include, Table
    end
  end
end