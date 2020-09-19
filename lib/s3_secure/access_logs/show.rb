class S3Secure::AccessLogs
  class Show < Base
    def run
      say "Bucket ACL:"
      pp bucket_acl_grants
      say "Bucket Logging:"
      pp bucket_logging
    end

    def bucket_logging
      # Tricky here, need to swtich the s3 client in case target_bucket is in another region
      with_regional_s3(target_bucket) do
        s3.get_bucket_logging(bucket: target_bucket).to_h
      end
    end
    memoize :bucket_logging

    def bucket_acl
      # Tricky here, need to swtich the s3 client in case target_bucket is in another region
      with_regional_s3(target_bucket) do
        s3.get_bucket_acl(bucket: target_bucket)
      end
    end
    memoize :bucket_acl

    def bucket_acl_grants
      bucket_acl.grants.map(&:to_h)
    end

    def enabled?
      acl_enabled? && logging_enabled?
    end

    def acl_enabled?
      grants = bucket_acl_grants & log_delivery_access_grants
      !grants.empty?
    end

    def logging_enabled?
      !bucket_logging.empty?
    end

    def log_delivery_access_grants
      [
        {
          grantee: {type: "Group", uri: "http://acs.amazonaws.com/groups/s3/LogDelivery"},
          permission: "WRITE"
        },{
          grantee: {type: "Group", uri: "http://acs.amazonaws.com/groups/s3/LogDelivery"},
          permission: "READ_ACP"
        }
      ]
    end

    def access_control_policy_with_log_delivery_permissions
      grants = bucket_acl_grants + log_delivery_access_grants
      { grants: grants, owner: owner }
    end

    def access_control_policy_without_log_delivery_permissions
      grants = bucket_acl_grants - log_delivery_access_grants
      { grants: grants, owner: owner }
    end

    def owner
      {
        display_name: bucket_acl.owner.display_name,
        id: bucket_acl.owner.id,
      }
    end

    def target_bucket
      @options[:target_bucket] || @bucket
    end

    def target_prefix
      prefix = @options[:target_prefix] || "access-logs"
      prefix += "/" unless prefix.ends_with?("/")
      prefix
    end

    def with_regional_s3(bucket)
      current_bucket, @bucket = @bucket, bucket
      result = yield
      @bucket = current_bucket
      result
    end
  end
end
