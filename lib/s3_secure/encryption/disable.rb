module S3Secure::Encryption
  class Disable < Base
    def run
      show = Show.new(@options)

      if show.enabled?
        s3.delete_bucket_encryption(bucket: @bucket) # returns resp = #<struct Aws::EmptyStructure>
        say "Bucket #{@bucket} encryption has been removed"
      else
        say "Bucket #{@bucket} is not configured with encryption at the bucket level"
      end
    end
  end
end
