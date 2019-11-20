require "json"

class S3Bucket::List
  class Policy
    include S3Bucket::AwsServices
    extend Memoist

    def initialize(options)
      @options = options
    end

    def run
      buckets.each do |bucket|
        @s3 = get_s3_regional_client(bucket)
        puts "Policy for bucket #{bucket.color(:green)}"
        policy = get_policy(bucket)

        if policy
          puts policy
        else
          puts "Bucket does not have a bucket policy"
        end
      end
    end

    def get_policy(bucket)
      resp = @s3.get_bucket_policy(bucket: bucket)
      data = JSON.load(resp.policy.read) # String
      JSON.pretty_generate(data)
    rescue Aws::S3::Errors::NoSuchBucketPolicy
    end

    def buckets
      resp = s3_client.list_buckets
      resp.buckets.map(&:name)
    end
    memoize :buckets
  end
end
