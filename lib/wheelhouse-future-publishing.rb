require 'wheelhouse'

require 'future_publishing/middleware'

module FuturePublishing
  class Plugin < Wheelhouse::Plugin
    hook(:"sidebar.options", "future_publishing/timestamp")

    initializer :middleware do |app|
      app.middleware.insert_after 'Wheelhouse::Middleware::Protection', 'FuturePublishing::Middleware'
    end
  end

  def sweep(site)
    to_publish = site.nodes.where(:publish_at.lte => Time.now)

    if to_publish.any?
      to_publish.each do |node|
        if node.published?
          # Node has a new draft to be published
          node.revert_to(:latest)
        else
          # Current version of the node should be published
          node.state = "Published"
        end

        node.publish_at = nil
        node.save(:version => false)

        if node.respond_to?(:versions)
          version = node.versions.first
          version.update_attributes(:published => true)
        end
      end

      site.clear_cache!
    end
  end
  module_function :sweep

  def sweep!
    Wheelhouse::Site.all.each { |s| sweep(s) }
  end
  module_function :sweep!
end
