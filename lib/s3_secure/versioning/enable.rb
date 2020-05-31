class S3Secure::Versioning
  class Enable < Base
    def run
      show = Show.new(@options)
      if show.enabled?
        puts "Bucket #{@bucket} is has versioning already enabled."
      else
        s3.put_bucket_versioning(
          bucket: @bucket,
          versioning_configuration: {
            # mfa_delete: "Disabled",
            status: "Enabled",
          },
        )
        puts "Versioning enabled on bucket #{@bucket}"
      end
    end
  end
end
