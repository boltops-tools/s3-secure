class S3Bucket::List
  class Policy < Base
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
  end
end
