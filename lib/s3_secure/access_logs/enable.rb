module S3Secure::AccessLogs
  class Enable < Base
    def run
      @show = Show.new(bucket: @bucket)
      add_bucket_acl
      enable_access_logging
    end

    # Bucket ACL applies on the target bucket only
    def add_bucket_acl
      if @show.acl_enabled?
        say "Bucket acl already has log delivery ACL"
        return
      end

      # require to add in order to use put_bucket_acl since this change
      # https://aws.amazon.com/blogs/aws/amazon-s3-block-public-access-another-layer-of-protection-for-your-accounts-and-buckets/
      s3.put_bucket_ownership_controls(
        bucket: @bucket,
        ownership_controls: { # required
          rules: [ # required
            {object_ownership: "ObjectWriter"}, # required, accepts BucketOwnerPreferred, ObjectWriter, BucketOwnerEnforced
          ],
        },
      )

      s3.put_bucket_acl(
        bucket: @bucket,
        access_control_policy: @show.access_control_policy_with_log_delivery_permissions,
      )
      say "Added to bucket acl that grants log delivery"
    end

    def enable_access_logging
      if @show.logging_enabled?
        say "Bucket access logging already enabled"
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
      say "Enabled access logging on the source bucket #{@bucket} to be delivered to the target bucket #{@show.target_bucket}"
    end
  end
end
