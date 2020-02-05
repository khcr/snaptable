require 'snaptable/helpers/table_helper'
require 'snaptable/helpers/buttons_helper'

module Snaptable
  class Engine < ::Rails::Engine
    require 'will_paginate'

    initializer 'Snaptable.tables' do
      ActionController::Base.send :include, Helpers::TableHelper
    end

    initializer 'Snaptable.buttons_helper' do
      ActionView::Base.send :include, Helpers::ButtonsHelper
    end
  end
end
