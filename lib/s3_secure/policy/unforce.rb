class S3Secure::Policy
  class Unforce < Base
    def initialize(options={})
      super
      @sid = options[:sid]
    end

    def run
      @s3 = s3_regional_client(@bucket)

      list = S3Secure::Policy::List.new(@options)
      list.set_s3(@s3)

      bucket_policy = list.get_policy(@bucket)
      document = Document.new(@bucket, bucket_policy, remove: true)
      if document.has?(@sid)
        # Set encryption rules
        # Ruby docs: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Client.html#put_bucket_policy-instance_method
        # API docs: https://docs.aws.amazon.com/AmazonS3/latest/API/API_ServerSideEncryptionByDefault.html
        #
        #    put_bucket_policy returns #<struct Aws::EmptyStructure>
        #
        policy_document = document.policy_document(@sid)

        if policy_document
          @s3.put_bucket_policy(
            bucket: @bucket,
            policy: policy_document,
          )
        else
          @s3.delete_bucket_policy(bucket: @bucket)
        end

        puts "Remove bucket policy to bucket #{@bucket}:"
        puts policy_document if policy_document
      else
        puts "Bucket policy for #{@bucket} does not have ForceSSLOnlyAccess policy statement. Nothing to be done."
      end
    end
  end
end
