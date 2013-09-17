# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "fluent-redislist"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Yifeng Jiang"]
  s.date        = %q{2013-09-17}
  s.email       = "uprushworld at gmail.com"
  s.homepage    = "https://github.com/uprush/fluent-redislist"
  s.summary     = "Redis list output plugin for Fluent"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency %q<fluentd>, ["~> 0.10.0"]
  s.add_dependency %q<redis>, ["~> 3.0.4"]
end
