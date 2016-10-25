# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crawl_station/version'

Gem::Specification.new do |s|
  s.name          = 'crawl_station'
  s.version       = CrawlStation::VERSION
  s.authors       = ['watsy0007']
  s.email         = ['watsy0007@gmail.com']

  s.summary       = 'crawl station system'
  s.description   = 'crawl station system'
  s.homepage      = 'https://github.io/watsy0007/crawl_sation'
  s.license       = 'MIT'

  s.required_ruby_version = '>= 2.3.0'

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|lib\/exe)/})
  end
  s.bindir        = 'exe'
  s.executables   = ['station']
  s.require_paths = ['lib']

  s.add_runtime_dependency 'activesupport', '~> 5.0', '>= 5.0.0'
  s.add_runtime_dependency 'activerecord', '~> 5.0', '>= 5.0.0'
  s.add_development_dependency 'bundler', '~> 1.13'
  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'pry', '~> 0.10'
end
