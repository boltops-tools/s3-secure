class S3Bucket::Policy
  class List < Base
    def run
      buckets.each do |bucket|
        @s3 = s3_regional_client(bucket)
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

    # Useful when calling List outside of the list CLI
    def set_s3(client)
      @s3 = client
    end
  end
end
