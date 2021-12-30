module S3Secure::Policy::Document
  class ForceSSLOnlyAccessRemove < Base
    def initialize(bucket, bucket_policy)
      # @bucket_policy is existing document policy
      @bucket, @bucket_policy = bucket, bucket_policy
    end

    def policy_document
      return nil if @bucket_policy.blank?

      updated_policy_document
    end

    def updated_policy_document
      policy = JSON.load(@bucket_policy)

      statements = policy["Statement"]
      has_force_ssl = !!statements.detect { |s| s["Sid"] == "ForceSSLOnlyAccess" }
      unless has_force_ssl
        raise "Bucket policy does not have ForceSSLOnlyAccess"
      end

      if statements.size == 1
        return nil # to signal for the entire bucket policy to be deleted
      else
        statements.delete_if { |s| s["Sid"] == "ForceSSLOnlyAccess" }
        policy["Statement"] = statements
      end

      policy
    end
  end
end
