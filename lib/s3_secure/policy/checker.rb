class S3Secure::Policy
  class Checker
    def initialize(bucket_policy)
      @bucket_policy = bucket_policy # existing document policy
    end

    def has?(sid)
      return false if @bucket_policy.blank?

      policy_document = JSON.load(@bucket_policy)
      statements = policy_document["Statement"]
      !!statements.detect { |s| s["Sid"] == sid || s["Sid"] == special_cases(sid) }
    end

    def special_cases(sid)
      map = {
        "ForceSslOnlyAccess" => "ForceSSLOnlyAccess", # Since these are AWS examples
      }
      map[sid]
    end
  end
end
