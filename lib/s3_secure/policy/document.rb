class S3Secure::Policy
  class Document
    extend Memoist
    include ForceSsl

    def initialize(bucket, bucket_policy)
      @bucket, @bucket_policy = bucket, bucket_policy # existing document policy
    end

    # Returns JSON text
    # Currently only support adding ForceSslOnlyAccess document policy.
    def policy_document(sid)
      meth = sid.underscore # ForceSslOnlyAccess => force_ssl_only_access
      policy = send(meth) if respond_to?(meth)
      JSON.pretty_generate(policy)
    end

    def checker
      Checker.new(@bucket_policy)
    end
    memoize :checker
  end
end
