# frozen_string_literal: true

require_relative "lib/rubynow_client/version"

Gem::Specification.new do |spec|
  spec.name = "rubynow_client"
  spec.version = RubynowClient::VERSION
  spec.authors = ["Devran Cosmo Uenal"]
  spec.email = ["maccosmo@gmail.com"]

  spec.summary = "Simple ServiceNow API Client for Ruby."
  spec.description = "RubyNowClient is a simple ServiceNow API Client for Ruby."
  spec.homepage = "https://bavmind.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/bavmind"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bavmind/rubynow_client"
  spec.metadata["changelog_uri"] = "https://github.com/bavmind/rubynow_client/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "rest-client", "~> 2.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
