$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "route_tracker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "route_tracker"
  s.version     = RouteTracker::VERSION
  s.authors     = ["Beetrack"]
  s.email       = ["tony@beetrack.com"]
  s.homepage    = "https://github.com/agrass/route-tracker"
  s.summary     = "route-tracker is a gem for track your users routes access"
  s.description = "track which routes already visited your users"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4"

  s.add_development_dependency "sqlite3"
end
