module S3Secure::AwsServices
  module S3
    extend Memoist

    @@s3_clients = {} # holds cached s3 regional clients cache
    def s3
      check_bucket!
      @@s3_clients[@bucket] ||= new_s3_regional_client
    end

    def s3_regional_client(bucket)
      temp = @bucket
      @bucket = bucket
      @@s3_clients[bucket] ||= new_s3_regional_client
      @bucket = temp
    end

    def new_s3_regional_client
      options = {}
      options[:endpoint] = "https://s3.#{region}.amazonaws.com"
      options[:region] = region
      Aws::S3::Client.new(options)
    rescue Aws::STS::Errors::RegionDisabledException
      puts "ERROR: Fail to establish client connection to region #{region}".color(:red)
      raise
    end

    # Generic s3 client. Will be configured to whatever region user has locally configured in ~/.aws/config
    # Used to call get_bucket_location to get each specific bucket's location.
    # Generally use the s3_regional_client instead of this.
    def s3_client
      Aws::S3::Client.new
    end
    memoize :s3_client

    def check_bucket!
      # IMPORANT: The class that includes this module must set @bucket before using the s3 method.
      unless @bucket
        raise "@bucket #{@bucket.inspect} is not set. The class must set @bucket before using the any client method."
      end
      region_map # triggers building region map for specific @bucket
    end

    @@region_map = {} # bucket to region map cache
    def region_map
      region = @@region_map[@bucket]
      return @@region_map if region # return cache

      # build cache
      resp = s3_client.get_bucket_location(bucket: @bucket)
      region = resp.location_constraint
      region = 'us-east-1' if region.empty? # "" means us-east-1
      @@region_map[@bucket] = region
      @@region_map
    end

    def region
      region_map[@bucket]
    end
  end
end