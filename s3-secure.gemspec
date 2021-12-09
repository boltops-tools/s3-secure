# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "s3_secure/version"

Gem::Specification.new do |spec|
  spec.name          = "s3-secure"
  spec.version       = S3Secure::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tongueroo@gmail.com"]
  spec.summary       = "S3 Bucket security hardening tool"
  spec.homepage      = "https://github.com/boltops-tools/s3-secure"
  spec.license       = "Apache2.0"

  git_installed      = system("type git > /dev/null 2>&1")
  spec.files         = git_installed ? `git ls-files`.split($/) : Dir.glob("**/*")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "aws-sdk-s3"
  spec.add_dependency "cli-format"
  spec.add_dependency "memoist"
  spec.add_dependency "rainbow"
  spec.add_dependency "text-table"
  spec.add_dependency "thor"
  spec.add_dependency "zeitwerk"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "cli_markdown"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
