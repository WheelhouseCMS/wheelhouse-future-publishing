unless defined?(FuturePublishing::NodeExtension)
  module FuturePublishing::NodeExtension
    extend ActiveSupport::Concern

    included do
      property :publish_at, Time
      before_validation :set_published_state
    end

  protected
    def set_published_state
      if publish_at && publish_at > Time.now
        self.state = "Draft"
      end
    end
  end
end

unless defined?(Wheelhouse::Resource::Node)
  require_dependency "wheelhouse/resource/concerns/node"
end

module Wheelhouse::Resource::Node
  include FuturePublishing::NodeExtension
end
