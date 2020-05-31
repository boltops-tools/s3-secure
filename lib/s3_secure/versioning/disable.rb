class S3Secure::Versioning
  class Disable < Base
    def run
      show = Show.new(@options)
      if show.enabled?
        s3.put_bucket_versioning(
          bucket: @bucket,
          versioning_configuration: {
            # mfa_delete: "Disabled",
            status: "Suspended",
          },
        )
        puts "Versioning Suspended on bucket #{@bucket}"
      else
        puts "Bucket #{@bucket} is already has versioning already Suspended or not Enabled."
      end
    end
  end
end
