class S3Secure::Encryption
  class Disable < Base
    def run
      @s3 = s3_regional_client(@bucket)

      list = S3Secure::Encryption::List.new(@options)
      list.set_s3(@s3)

      rules = list.get_encryption_rules(@bucket)
      if rules
        @s3.delete_bucket_encryption(bucket: @bucket) # returns resp = #<struct Aws::EmptyStructure>
        puts "Bucket #{@bucket} encryption has been removed"
      else
        puts "WARN: Bucket #{@bucket} is not configured with encryption at the bucket level".color(:yellow)
      end
    end
  end
end
