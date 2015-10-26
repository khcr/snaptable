require 'snaptable/helpers/table'

module Snaptable
  class Engine < ::Rails::Engine
    require 'will_paginate'
    require 'jquery-rails'

    initializer 'Snaptable.tables' do
      ActionController::Base.send :include, Helpers
    end

    initializer 'Snaptable.buttons_helper' do
      ActionView::Base.send(:include, ButtonsHelper)
    end
  end
end
