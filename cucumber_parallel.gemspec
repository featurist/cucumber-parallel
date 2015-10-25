# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'cucumber_parallel'
  s.version     = File.read(File.expand_path("../lib/cucumber/parallel/version", __FILE__))
  s.authors     = ["Josh Chisholm"]
  s.description = "Runs cucumber scenarios in many contexts in parallel"
  s.summary     = "cucumber_parallel-#{s.version}"
  s.email       = "josh@featurist.co.uk"
  s.homepage    = "http://www.featurist.co.uk"
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency 'cucumber', '~> 2.0.0.rc'
  s.add_dependency 'parallel', '1.6.1'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'

  s.rubygems_version = ">= 1.6.1"
  s.files            = `git ls-files`.split("\n").reject {|path| path =~ /\.gitignore$/ }
  s.test_files       = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_path     = "lib"
end
