# -*- encoding: utf-8 -*-
require File.expand_path('../lib/g11n/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Xavier Via"]
  gem.email         = ["xavier.via.canel@gmail.com"]
  gem.description   = %q{Internationalization library focused in simplicity of implementation}
  gem.summary       = %q{Internationalization library focused in simplicity of implementation}
  gem.homepage      = "http://github.com/Fetcher/g11n"

  gem.add_dependency "symboltable"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "cucumber"
  gem.add_development_dependency "fast"
  gem.add_development_dependency "pry"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "g11n"
  gem.require_paths = ["lib"]
  gem.version       = G11n::VERSION
end
