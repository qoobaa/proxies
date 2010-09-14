# -*- encoding: utf-8 -*-
require File.expand_path("../lib/proxies/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "proxies"
  s.version     = Proxies::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jakub Kuźma"]
  s.email       = ["qoobaa@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/proxies"
  s.summary     = "Proxies can even proxy other proxies"
  s.description = "Proxies can even proxy other proxies"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "proxies"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "test-unit", ">= 2"
  s.add_development_dependency "mocha"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
