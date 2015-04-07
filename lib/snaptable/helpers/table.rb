require 'snaptable/constructor/base_table'

module Snaptable
	module Helpers

		class Table < Snaptable::Constructor::BaseTable

			def initialize(parent, model, collection = nil, options = {})
				super(parent, collection, options)
				@model = model
			end

			def values(element)
				element.attributes.map do |attr_name, attr_value|
					if attr_value.is_a?(Date) || attr_value.is_a?(Time) || attr_value.is_a?(DateTime)
						l(attr_value, format: :short)
					else
						attr_value
					end.to_s
				end
			end

			def model
				@model
			end

			module Search

				def self.associations
			 		nil
			 	end

			 	def self.fields
			 		nil
			 	end

			end
		end
	end
end