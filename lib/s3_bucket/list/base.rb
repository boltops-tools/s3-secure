require "json"

class S3Bucket::List
  class Base
    include S3Bucket::AwsServices
    extend Memoist

    def initialize(options)
      @options = options
    end

    def buckets
      resp = s3_client.list_buckets
      resp.buckets.map(&:name)
    end
    memoize :buckets
  end
end
