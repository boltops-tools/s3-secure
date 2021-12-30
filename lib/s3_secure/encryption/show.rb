module S3Secure::Encryption
  class Show < Base
    def run
      if rules
        say "Bucket #{@bucket} is configured with these encryption rules:"
        say rules.map(&:to_h)
      else
        say "Bucket #{@bucket} is not configured with encryption at the bucket level"
      end
      rules
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
