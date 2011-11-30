# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rkill/version"

Gem::Specification.new do |s|
  s.name        = "rkill"
  s.version     = Rkill::VERSION
  s.authors     = ["Tal Atlas"]
  s.email       = ["me@tal.by"]
  s.homepage    = "http://github.com/talby/rkill"
  s.summary     = %q{A replacement for the unix Kill command}
  s.description = %q{A replacement for the unix Kill command}

  s.rubyforge_project = "rkill"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.default_executable = %q{rkill}
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "ps", '>= 0.0.6'
  s.add_runtime_dependency "ansi"
end
