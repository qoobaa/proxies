# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{true_proxy}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jakub Kuźma"]
  s.date = %q{2010-04-01}
  s.description = %q{TrueProxy can even proxy other proxies}
  s.email = %q{qoobaa@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/true_proxy.rb",
     "test/helper.rb",
     "test/test_true_proxy_extend.rb",
     "test/test_true_proxy_owner.rb",
     "test/test_true_proxy_target.rb"
  ]
  s.homepage = %q{http://github.com/qoobaa/true_proxy}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{TrueProxy can even proxy other proxies}
  s.test_files = [
    "test/test_true_proxy_target.rb",
     "test/test_true_proxy_extend.rb",
     "test/helper.rb",
     "test/test_true_proxy_owner.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<test-unit>, [">= 2"])
    else
      s.add_dependency(%q<test-unit>, [">= 2"])
    end
  else
    s.add_dependency(%q<test-unit>, [">= 2"])
  end
end
