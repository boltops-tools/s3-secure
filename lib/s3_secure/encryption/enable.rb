class S3Secure::Encryption
  class Enable < Base
    def run
      @s3 = s3_regional_client(@bucket)

      list = S3Secure::Encryption::List.new(@options)
      list.set_s3(@s3)

      rules = list.get_encryption_rules(@bucket)
      if rules
        # check rules to see if encryption is already set of some sort
        puts "Bucket #{@bucket} already has encryption rules:"
        puts rules.map(&:to_h)
      else
        # Set encryption rules
        # Ruby docs: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Client.html#put_bucket_encryption-instance_method
        # API docs: https://docs.aws.amazon.com/AmazonS3/latest/API/API_ServerSideEncryptionByDefault.html
        #
        #    put_bucket_encryption returns #<struct Aws::EmptyStructure>
        #
        @s3.put_bucket_encryption(
          bucket: @bucket,
          server_side_encryption_configuration: {
            rules: [rule]})
        puts "Encyption enabled on bucket #{@bucket} with rules:"
        pp rule
      end
    end

    def rule
      options = if @options[:kms_key] # SSE-KMS
                  {
                    sse_algorithm: "aws:kms", # required, accepts AES256, aws:kms
                    kms_master_key_id: @options[:kms_key], # "SSEKMSKeyId",
                  }
                else # SSE-S3
                  { sse_algorithm: "AES256" }
                end
      { apply_server_side_encryption_by_default: options }
    end
  end
end
