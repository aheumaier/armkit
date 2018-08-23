
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "armkit/version"

Gem::Specification.new do |spec|
  spec.name          = "simple_starting_example.dsl"
  spec.version       = Armkit::VERSION
  spec.authors       = ["Andreas Heumaier"]
  spec.email         = ["andreas.heumaier@microsoft"]

  spec.summary       = %q{ Write a short summary, because RubyGems requires one.}
  spec.description   = %q{ Write a longer description or delete this line.}
  spec.homepage      = "https://simple_starting_example.dsl.andreasheumaier.de"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'http://simple_starting_example.dsl.com'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "examples"
  spec.executables   = spec.files.grep(%r{^examples/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "azure_mgmt_compute"
  spec.add_development_dependency "azure_mgmt_network"
  spec.add_development_dependency 'ms_rest_azure'
  spec.add_development_dependency 'json'
end