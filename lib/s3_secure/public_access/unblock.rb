module S3Secure::PublicAccess
  class Unblock < Base
    def run
      resp = s3.delete_public_access_block(
        bucket: @bucket,
      )
      $stderr.puts("Removed public access block configuration for bucket: #{@bucket}")
      resp
    end
  end
end

