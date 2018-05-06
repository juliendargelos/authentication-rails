$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'authentication/rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'authentication-rails'
  s.version     = Authentication::Rails::VERSION
  s.authors     = ['Julien Dargelos']
  s.email       = ['contact@juliendargelos.com']
  s.homepage    = 'https://www.github.com/juliendargelos/authentication-rails'
  s.summary     = 'Authenticate with Rails.'
  s.description = 'Provide a Rails authentication active model.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2.0'

  s.add_development_dependency 'bcrypt'
  s.add_development_dependency 'sqlite3'
end
