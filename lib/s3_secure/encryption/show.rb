class S3Secure::Encryption
  class Show < Base
    def run
      if rules
        puts "Bucket #{@bucket} is configured with these encryption rules:"
        puts rules.map(&:to_h)
      else
        puts "Bucket #{@bucket} is not configured with encryption at the bucket level"
      end
    end

    def enabled?
      !!(rules && !rules.empty?)
    end

    def rules
      resp = s3.get_bucket_encryption(bucket: @bucket)
      resp.server_side_encryption_configuration.rules # Aws::Xml::DefaultList object
    rescue Aws::S3::Errors::ServerSideEncryptionConfigurationNotFoundError
    end
    memoize :rules
  end
end
