module S3Secure::Versioning
  class Show < Base
    def run
      if enabled?
        say "This S3 bucket has versioning enabled"
      else
        say "This S3 bucket does not have versioning enabled"
      end
      details = get_versioning(@bucket).to_h
      unless details.empty?
        say "Bucket versioning details: "
        pp details
      end
    end

    def enabled?
      versioning = get_versioning(@bucket)
      versioning.status == "Enabled" # Can be Enabled, Suspended, or nil
    end

    def get_versioning(bucket)
      s3.get_bucket_versioning(bucket: bucket) # resp
    rescue Aws::S3::Errors::ServerSideEncryptionConfigurationNotFoundError
    end
    memoize :get_versioning
  end
end
