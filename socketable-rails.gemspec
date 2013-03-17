$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "socketable-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "socketable-rails"
  s.version     = SocketableRails::VERSION
  s.authors     = ["Rafael Garcia"]
  s.email       = ["rafbgarcia@gmail.com"]
  s.homepage    = "https://github.com/rafbgarcia/socketable-rails"
  s.summary     = "Rails websocket made easy"
  s.description = "Very small and simple gem that makes using websockets really easy."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.12"
  s.add_dependency "websocket-rails"
  s.add_dependency "coffee-rails"
end
