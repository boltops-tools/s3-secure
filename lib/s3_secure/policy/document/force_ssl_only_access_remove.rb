class S3Secure::Policy::Document
  class ForceSSLOnlyAccessRemove
    def initialize(bucket, bucket_policy)
      # @bucket_policy is existing document policy
      @bucket, @bucket_policy = bucket, bucket_policy
    end

    def policy_document
      if @bucket_policy.blank?
        full_policy_document
      else
        updated_policy_document
      end
    end

    def updated_policy_document
      policy = JSON.load(@bucket_policy)
      policy["Statement"] << ssl_enforce_statement unless checker.has?("ForceSSLOnlyAccess")
      policy
    end

    def full_policy_document
      {"Version"=>"2012-10-17",
       "Statement"=>[ssl_enforce_statement]}
    end

    def ssl_enforce_statement
      {
        "Sid"=>"ForceSSLOnlyAccess",
        "Effect"=>"Deny",
        "Principal"=>"*",
        "Action"=>"s3:GetObject",
        "Resource"=>"arn:aws:s3:::#{@bucket}/*",
        "Condition"=>{"Bool"=>{"aws:SecureTransport"=>"false"}}
      }
    end
  end

  ForceSSLOnlyAccessRemove = ForceSSLOnlyAccessRemove
end
