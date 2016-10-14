unless defined?(Wheelhouse::Resource::Versioned)
  require_dependency "wheelhouse/resource/concerns/versioned"
end

module Wheelhouse::Resource::Versioned
  UNVERSIONED_ATTRIBUTES << :published_at

  def set_version_attributes
    @_version_attributes = {}

    @_version_attributes[:version] = version
    @_version_attributes[:published] = published? unless published_resource_was_saved_as_draft?

    @_version_attributes[:version_attributes] = begin
      attrs = attributes.except(*UNVERSIONED_ATTRIBUTES)

      if published_resource_was_saved_as_draft?
        # Reset resource attributes to previous (published) state
        self.attributes = changed_attributes.except(:latest_version, :publish_at)
      elsif state == 'Unpublish'
        # Remove published status from all versions
        versions.published.update_all(:published => false)
        self.state = 'Draft'
      end

      attrs.to_mongo
    end

    @_version_attributes
  end
end
