Gem::Specification.new do |s|
  s.name        = "wheelhouse-future-publishing"
  s.platform    = Gem::Platform::RUBY
  s.version     = "0.1"

  s.summary     = "Future timestamp publishing plugin for Wheelhouse CMS"
  s.description = "Allows Wheelhouse CMS pages and other resources to be published at a future date/time."
  s.author      = "Sam Pohlenz"
  s.email       = "sam@wheelhousecms.com"
  s.homepage    = "https://www.wheelhousecms.com"

  s.files        = Dir["{app,lib}/**/*"]
  s.require_path = "lib"

  s.add_dependency("wheelhouse", "~> 1.1.13")
end
