module Snaptable
  module Rails
    class Engine < ::Rails::Engine
      require "will_paginate"

      initializer "Snaptable.assets.precompile" do |app|
        app.config.assets.precompile +=%w(autotable.js autotable.css)
      end
    end
  end
end