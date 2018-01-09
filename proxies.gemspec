# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "proxies/version"

Gem::Specification.new do |spec|
  spec.name          = "proxies"
  spec.version       = Proxies::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Kuba Kuźma"]
  spec.email         = ["kuba@kubakuzma.com"]

  spec.summary     = "Proxies can even proxy other proxies"
  spec.description = "Proxies can even proxy other proxies"
  spec.homepage    = "http://rubygems.org/gems/proxies"
  spec.license     = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "mocha"
end
