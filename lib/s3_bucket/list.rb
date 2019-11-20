require "json"

module S3Bucket
  class List
    include AwsServices
    extend Memoist

    def initialize(options)
      @options = options
    end

    def run
      buckets.each do |bucket|
        puts "Policy for bucket #{bucket.color(:green)}"
        begin
          policy = get_policy(bucket)
        rescue Aws::S3::Errors::PermanentRedirect
          puts <<~EOL
            WARN: bucket does not existing in the current region: #{current_region}.
            You will need to specify the region explicitly.
            Example:

                bucket_policy list --region REGION

            Moving onto next bucket
          EOL
          next
        end

        if policy
          puts policy
        else
          puts "Bucket does not have a bucket policy"
        end
      end
    end

    def get_policy(bucket)
      resp = s3.get_bucket_policy(bucket: bucket)
      data = JSON.load(resp.policy.read) # String
      JSON.pretty_generate(data)
    rescue Aws::S3::Errors::NoSuchBucketPolicy
    end

    def buckets
      resp = s3.list_buckets
      resp.buckets.map(&:name)
    end
    memoize :buckets

    def current_region
      `aws configure get region`.strip
    end
    memoize :current_region
  end
end
