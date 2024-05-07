# frozen_string_literal: true

require_relative 'lib/brevo_rails/version'

Gem::Specification.new do |s|
  s.name        = "brevo-rails"
  s.version = BrevoRails::VERSION
  s.summary     = "Send transactional email with Brevo"
  s.description = "Send transactional email with Brevo"
  s.authors     = ["Franck D'agostini"]
  s.email       = "franck.dagostini@gmail.com"
  s.files       = ["lib/brevo_rails.rb"]
  s.homepage    = "https://rubygems.org/gems/brevo_rails"
  s.license       = "MIT"
  s.required_ruby_version = '>= 2.7.0'
  s.require_paths = ['lib']

  s.add_development_dependency 'debug', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 3.6', '>= 3.6.0'
  s.add_development_dependency 'mail', '~> 2.5', '>= 2.5.4'
  # s.add_runtime_dependency "sib-api-v3-sdk", "~> 9.0", "> 9.0"
  s.add_runtime_dependency "brevo", "~> 2.0"
  s.add_runtime_dependency "activesupport", "> 4.3"

end
