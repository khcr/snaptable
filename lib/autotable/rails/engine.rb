module Autotable
  module Rails
    class Engine < ::Rails::Engine
      initializer "Autotable.assets.precompile" do |app|
        app.config.assets.precompile +=%w(autotable.js autotable.css)
      end
    end
  end
end