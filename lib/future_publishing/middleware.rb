module FuturePublishing
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      unless asset_request?(env) || (site = env['wheelhouse.site']).nil?
        FuturePublishing.sweep(site)
      end

      @app.call(env)
    end

  private
    def asset_request?(env)
      env['PATH_INFO'] =~ /^\/assets\//
    end
  end
end
