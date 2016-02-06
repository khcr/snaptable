require 'snaptable/constructor/sortable'
require 'snaptable/constructor/collection'
require 'snaptable/constructor/renderer'

module Snaptable
  module Constructor

      class BaseTable < SimpleDelegator
        include Sortable
        include Collection
        include Renderer

        def initialize(parent, collection = nil, options = {})
          super(parent)
          @options = options
          @collection = collection || model
          @token = stored_token if Snaptable.use_permission
        end

        def options
          @options
        end

        def url
          :id
        end

        private

        def stored_token
          session[:token] = params[:token] if params[:token]
          return session[:token]
        end
      end

  end
end

BaseTable = Snaptable::Constructor::BaseTable
