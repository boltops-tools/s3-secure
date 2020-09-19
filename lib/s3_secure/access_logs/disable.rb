class S3Secure::AccessLogs
  class Disable < Base
    def run
      @show = Show.new(bucket: @bucket)

      remove_access_logging
      remove_bucket_acl
    end

    def remove_access_logging
      unless @show.logging_enabled?
        say "Bucket #{@bucket} is not configured with access logging. So nothing to remove."
        return
      end

      s3.put_bucket_logging(
        bucket: @bucket, # source
        bucket_logging_status: {}, # empty hash to remove
      )
      say "Bucket #{@bucket} access logging removed"
    end

    def remove_bucket_acl
      unless @show.acl_enabled?
        say "Bucket #{@bucket} is not configured the log delivery ACL. So nothing to remove."
        return
      end

      access_control_policy = @show.access_control_policy_without_log_delivery_permissions
      s3.put_bucket_acl(
        bucket: @bucket,
        access_control_policy: access_control_policy,
      )
      say "Bucket #{@bucket} ACL Log Delivery removed"
    end
  end
end
