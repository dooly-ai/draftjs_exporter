# frozen_string_literal: true
module DraftjsExporter
  module Entities
    class Video
      attr_reader :configuration

      def initialize(configuration = { className: nil })
        # Default styles for images
        @configuration = configuration.merge({allowfullscreen: "", frameboder: "0"})
      end

      def call(parent_element, data)
        args = { src: data.fetch(:data, {}).fetch(:src) }
        args[:class] = configuration.fetch(:className) if configuration[:className]

        element = parent_element.document.create_element('iframe', args)
        parent_element.add_child(element)
        element
      end
    end
  end
end
