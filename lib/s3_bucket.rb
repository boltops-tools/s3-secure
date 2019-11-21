$:.unshift(File.expand_path("../", __FILE__))
require "json"
require "memoist"
require "rainbow/ext/string"
require "s3_bucket/version"

require "s3_bucket/autoloader"
S3Bucket::Autoloader.setup

module S3Bucket
  class Error < StandardError; end
end
