# frozen_string_literal: true
module DraftjsExporter
  module Entities
    class Video
      attr_reader :configuration

      def initialize(configuration = { className: nil })
        # Default styles for images
        @configuration = configuration.merge({allowfullscreen: "1", frameborder: "0", allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"})
      end

      def call(parent_element, data)
        # Check for youtube links, and change watch to embed in order to embed correctly
        src = data.fetch(:data, {}).fetch(:src)
        if src && src.include?("https://www.youtube.com/watch")
          video_id = src.split("=")[1]
          src = "https://www.youtube.com/embed/#{video_id}"
        end

        args = { src:  src}
        args[:class] = configuration.fetch(:className) if configuration[:className]
        args[:allowfullscreen] = configuration.fetch(:allowfullscreen) if configuration[:allowfullscreen]
        args[:allow] = configuration.fetch(:allow) if configuration[:allow]
        args[:frameborder] = configuration.fetch(:frameborder) if configuration[:frameborder]

        element = parent_element.document.create_element('iframe', args)
        parent_element.add_child(element)
        element
      end
    end
  end
end
