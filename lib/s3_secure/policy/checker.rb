module S3Secure::Policy
  class Checker
    def initialize(bucket_policy)
      @bucket_policy = bucket_policy # existing document policy
    end

    def has?(sid)
      return false if @bucket_policy.blank?

      policy_document = JSON.load(@bucket_policy)
      statements = policy_document["Statement"]
      !!statements.detect { |s| s["Sid"] == sid }
    end
  end
end
