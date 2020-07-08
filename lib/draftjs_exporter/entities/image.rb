# frozen_string_literal: true
module DraftjsExporter
  module Entities
    class Image
      attr_reader :configuration

      def initialize(configuration = { className: nil })
        # Default styles for images
        @configuration = configuration.merge({style: "position: relative; width: 40%; cursor: default;"})
      end

      def call(parent_element, data)
        args = { src: data.fetch(:data, {}).fetch(:src) }
        args[:class] = configuration.fetch(:className) if configuration[:className]

        element = parent_element.document.create_element('img', args)
        parent_element.add_child(element)
        element
      end
    end
  end
end
