class S3Secure::Policy
  class Enforce < Base
    def initialize(options={})
      super
      @sid = options[:sid]
    end

    def run
      show = S3Secure::Policy::Show.new(@options)

      bucket_policy = show.policy
      document = Document.new(@bucket, bucket_policy)
      if document.has?(@sid)
        puts "Bucket policy for #{@bucket} has ForceSSLOnlyAccess policy statement already:"
        puts bucket_policy
      else
        # Set encryption rules
        # Ruby docs: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Client.html#put_bucket_policy-instance_method
        # API docs: https://docs.aws.amazon.com/AmazonS3/latest/API/API_ServerSideEncryptionByDefault.html
        #
        #    put_bucket_policy returns #<struct Aws::EmptyStructure>
        #
        policy_document = document.policy_document(@sid)
        s3.put_bucket_policy(
          bucket: @bucket,
          policy: policy_document,
        )
        puts "Add bucket policy to bucket #{@bucket}:"
        puts policy_document
      end
    end
  end
end
