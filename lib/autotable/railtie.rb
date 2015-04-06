module Autotable
  class Railtie < Rails::Railtie
    initializer 'autotable.view_helpers' do
      # ActionView::Base.send :include, ViewHelpers
    end
  end
end