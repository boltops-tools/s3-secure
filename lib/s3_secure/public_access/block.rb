module S3Secure::PublicAccess
  class Block < Base
    def run
      resp = s3.put_public_access_block(
        bucket: @bucket,
        public_access_block_configuration: {
          block_public_acls: true,
          ignore_public_acls: true,
          block_public_policy: true,
          restrict_public_buckets: true,
        },
      )
      say "Public access blocked for bucket: #{@bucket}"
      resp
    end
  end
end

