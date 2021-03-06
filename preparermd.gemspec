# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'preparermd/version'

Gem::Specification.new do |spec|
  spec.name          = "preparermd"
  spec.version       = PreparerMD::VERSION
  spec.authors       = ["Ash Wilson"]
  spec.email         = ["smashwilson@gmail.com"]

  spec.summary       = %q{Build and submit Jekyll content repositories to a Deconst site.}
  spec.homepage      = "https://github.com/deconst/preparer-jekyll"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "jekyll", "2.5.3"
  spec.add_runtime_dependency "faraday", "0.9.1"
  spec.add_runtime_dependency "jekyll-assets", "0.14.0"
  spec.add_runtime_dependency "therubyracer", "0.12.2"
  spec.add_runtime_dependency "json", "1.8.3"
end
