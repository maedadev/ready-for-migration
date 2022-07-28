$:.push File.expand_path("lib", __dir__)

require "ready/for/migration/version"

Gem::Specification.new do |spec|
  spec.name        = "ready-for-migration"
  spec.version     = Ready::For::Migration::VERSION
  spec.authors     = ["bizside-developers"]
  spec.email       = ["bizside-developers@lab.acs-jp.com"]
  spec.homepage    = "https://github.com/maedadev/ready-for-migration"
  spec.summary     = "ready for migration"
  spec.description = "add api to check ready for DB migration of rails application"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.2.0", "< 7.2.0"

  spec.add_development_dependency 'sqlite3', '>= 1.3', '< 1.5.0'
end
