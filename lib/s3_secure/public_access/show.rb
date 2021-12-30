module S3Secure::PublicAccess
  class Show < Base
    def run
      resp = s3.get_public_access_block(
        bucket: @bucket,
      )
      $stderr.puts(resp.to_h)
      resp
    rescue Aws::S3::Errors::NoSuchPublicAccessBlockConfiguration
      $stderr.puts "No public access block configuration found for bucket: #{@bucket}"
    end

    def blocked?
      resp = s3.get_public_access_block(
        bucket: @bucket,
      )
      resp.to_h[:public_access_block_configuration] == {
        block_public_acls: true,
        block_public_policy: true,
        ignore_public_acls: true,
        restrict_public_buckets: true,
      }
    rescue Aws::S3::Errors::NoSuchPublicAccessBlockConfiguration
      false
    end
  end
end
