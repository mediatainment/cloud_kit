Gem::Specification.new do |s|
  s.name        = 'cloud_kit-ruby'
  s.version     = '0.1.0'
  s.summary     = "CloudKit Ruby bindings"
  s.description = "A gem which provides initial Ruby bindings for Apple's CloudKit"
  s.authors     = ["Matt Brooke-Smith"]
  s.email       = 'matt@futureworkshops.com'
  s.files       = ["lib/cloud_kit.rb", "lib/create_operation.rb", "lib/modify_operation.rb"]
  s.homepage    = 'http://rubygems.org/gems/cloud_kit-ruby'
  s.license     = 'MIT'
  
  s.add_dependency 'httparty'
  
  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake'
end
