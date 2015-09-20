require 'snaptable/helpers/table'

module Snaptable
  class Engine < ::Rails::Engine
    require 'will_paginate'

    initializer 'Snaptable.tables' do
      ActionController::Base.send :include, Helpers
    end
  end
end
