require "aws-sdk-s3"

module S3Bucket
  module AwsServices
    extend Memoist

    def s3
      Aws::S3::Client.new(s3_options)
    end
    memoize :s3

    def s3_options
      options = {}
      options[:endpoint] = "https://s3.#{@options[:region]}.amazonaws.com" if @options[:region]
      options[:region] = @options[:region] if @options[:region]
      options
    end
  end
end
