class S3Secure::Policy
  class Show < Base
    def run
      if policy
        puts "Bucket #{@bucket} is configured with this policy:"
        puts policy
        # puts policy.map(&:to_h)
      else
        puts "Bucket #{@bucket} is not configured bucket policy"
      end
    end

    def policy
      resp = s3.get_bucket_policy(bucket: @bucket)
      data = JSON.load(resp.policy.read) # String
      JSON.pretty_generate(data)
    rescue Aws::S3::Errors::NoSuchBucketPolicy
    end
    memoize :policy
  end
end
