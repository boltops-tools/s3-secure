class S3Bucket::Policy
  class Enable < Base
    def run
      @s3 = s3_regional_client(@bucket)

      list = S3Bucket::Policy::List.new(@options)
      list.set_s3(@s3)

      bucket_policy = list.get_policy(@bucket)
      if bucket_policy
        # check rules to see if bucket_policy is already set of some sort
        puts "Bucket #{@bucket} already has a bucket policy:"
        puts bucket_policy
      else
        # Set encryption rules
        # Ruby docs: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Client.html#put_bucket_policy-instance_method
        # API docs: https://docs.aws.amazon.com/AmazonS3/latest/API/API_ServerSideEncryptionByDefault.html
        #
        #    put_bucket_policy returns #<struct Aws::EmptyStructure>
        #
        puts "policy:"
        puts policy_document
        @s3.put_bucket_policy(
          bucket: @bucket,
          policy: policy_document,
        )
        puts "Add bucket policy to bucket #{@bucket}:"
        puts policy_document
      end
    end

    def policy_document
      <<~JSON
        {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Sid": "ForceSSLOnlyAccess",
              "Effect": "Deny",
              "Principal": "*",
              "Action": "s3:GetObject",
              "Resource": "arn:aws:s3:::#{@bucket}/*",
              "Condition": {
                "Bool": {
                  "aws:SecureTransport": "false"
                }
              }
            }
          ]
        }
      JSON
    end
  end
end
