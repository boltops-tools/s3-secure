class S3Secure::Policy::Document
  module ForceSsl
    def force_ssl_only_access
      if @bucket_policy.blank?
        ssl_full_policy_document
      else
        ssl_updated_policy_document
      end
    end

    def ssl_updated_policy_document
      policy = JSON.load(@bucket_policy)
      policy["Statement"] << ssl_enforce_statement unless checker.has?("ForceSslOnlyAccess")
      policy
    end

    def ssl_full_policy_document
      {"Version"=>"2012-10-17",
       "Statement"=>[ssl_enforce_statement]}
    end

    def ssl_enforce_statement
      {
        "Sid"=>"ForceSslOnlyAccess",
        "Effect"=>"Deny",
        "Principal"=>"*",
        "Action"=>"s3:GetObject",
        "Resource"=>"arn:aws:s3:::#{@bucket}/*",
        "Condition"=>{"Bool"=>{"aws:SecureTransport"=>"false"}}
      }
    end
  end
end
