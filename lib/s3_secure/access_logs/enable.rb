class S3Secure::AccessLogs
  class Enable < Base
    def run
      @show = Show.new(bucket: @bucket)
      add_bucket_acl
      enable_access_logging
    end

    # Bucket ACL applies on the target bucket only
    def add_bucket_acl
      if @show.acl_enabled?
        puts "Bucket acl already has log delivery ACL"
        return
      end

      s3.put_bucket_acl(
        bucket: @bucket,
        access_control_policy: @show.access_control_policy_with_log_delivery_permissions,
      )
      puts "Added to bucket acl that grants log delivery"
    end

    def enable_access_logging
      if @show.logging_enabled?
        puts "Bucket access logging already enabled"
        return
      end

      s3.put_bucket_logging(
        bucket: @bucket, # source
        bucket_logging_status: {
          logging_enabled: {
            target_bucket: @show.target_bucket,
            target_prefix: @show.target_prefix,
          },
        },
      )
      puts "Enabled access logging on the source bucket #{@bucket} to be delivered to the target bucket #{@show.target_bucket}"
    end
  end
end
