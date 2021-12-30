require "aws-sdk-s3"

module S3Secure
  module AwsServices
    extend Memoist
    include S3

    def sts
      Aws::STS::Client.new
    end
    memoize :sts
  end
end
