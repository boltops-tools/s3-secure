$:.unshift(File.expand_path("../", __FILE__))
require "json"
require "memoist"
require "rainbow/ext/string"
require "s3_secure/version"

require "s3_secure/autoloader"
S3Secure::Autoloader.setup

module S3Secure
  class Error < StandardError; end
end
