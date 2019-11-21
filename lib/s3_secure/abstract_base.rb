module S3Secure
  class AbstractBase
    include S3Secure::AwsServices
    extend Memoist

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
