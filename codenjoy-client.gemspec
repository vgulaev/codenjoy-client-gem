require_relative 'lib/codenjoy/client/version'

Gem::Specification.new do |spec|
  spec.name          = "codenjoy-client"
  spec.version       = Codenjoy::Client::VERSION
  spec.authors       = ["vgulaev"]
  spec.email         = ["vgulaev@yandex.ru"]

  spec.summary       = %q{This client tools for play https://dojorena.io/.}
  spec.description   = %q{This client tools for play https://dojorena.io/.}
  spec.homepage      = "https://github.com/vgulaev/codenjoy-client"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/vgulaev/codenjoy-client"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faye-websocket"
  spec.add_development_dependency "faye-websocket"
end
