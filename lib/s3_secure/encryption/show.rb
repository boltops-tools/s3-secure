class S3Secure::Encryption
  class Show < Base
    def run
      @s3 = s3_regional_client(@bucket)

      list = S3Secure::Encryption::List.new(@options)
      list.set_s3(@s3)

      rules = list.get_encryption_rules(@bucket)
      if rules
        puts "Bucket #{@bucket} is configured with these encryption rules:"
        puts rules.map(&:to_h)
      else
        puts "Bucket #{@bucket} is not configured with encryption at the bucket level"
      end
    end
  end
end
