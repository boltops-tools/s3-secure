class S3Secure::Policy
  class Show < Base
    def run
      @s3 = s3_regional_client(@bucket)

      list = S3Secure::Policy::List.new(@options)
      list.set_s3(@s3)

      policy = list.get_policy(@bucket)
      if policy
        puts "Bucket #{@bucket} is configured with this policy:"
        puts policy
        # puts policy.map(&:to_h)
      else
        puts "Bucket #{@bucket} is not configured bucket policy"
      end
    end
  end
end
