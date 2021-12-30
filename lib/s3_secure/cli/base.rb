class S3Secure::CLI
  class Base
    extend Memoist
    include S3Secure::AwsServices
    include Say

    def initialize(options={})
      @options = options
      @bucket = options[:bucket] # not set on the list command but common enough to set here
    end

    def buckets
      resp = s3_client.list_buckets
      resp.buckets.map(&:name)
    end
    memoize :buckets
  end
end
