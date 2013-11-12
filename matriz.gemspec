# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matriz/version'

Gem::Specification.new do |spec|
  spec.name          = "matriz"
  spec.version       = Matriz::VERSION
  spec.authors       = ["Cristian Luis"]
  spec.email         = ["alu0100693386@ull.edu.es"]
  spec.description   = %q{Librearía para representar matrices}
  spec.summary       = %q{Se pretende crear una clase matriz capaz de generar, representar y operar con matrices densas y sispersas tanto con fracciones como con enteros.}
  spec.homepage      = "https://github.com/alu0100693386/prct09.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-bundler'


end
