require "aws-sdk-s3"

module S3Bucket
  module AwsServices
    extend Memoist

    @@buckets = {} # holds bucket => region map
    def s3_regional_client(bucket)
      region = @@buckets[bucket]

      unless region
        resp = s3_client.get_bucket_location(bucket: bucket)
        region = resp.location_constraint
        region = 'us-east-1' if region.empty? # "" means us-east-1
      end

      new_s3_regional_client(region)
    end

    def new_s3_regional_client(region=nil)
      options = {}
      options[:endpoint] = "https://s3.#{region}.amazonaws.com" if region
      options[:region] = region if region
      Aws::S3::Client.new(options)
    end
    memoize :new_s3_regional_client

    # Generic s3 client. Will be configured to whatever region user has locally configured in ~/.aws/config
    # Used to call get_bucket_location to get each specific bucket's location.
    # Generally use the s3_regional_client instead of this.
    def s3_client
      Aws::S3::Client.new
    end
    memoize :s3_client
  end
end
