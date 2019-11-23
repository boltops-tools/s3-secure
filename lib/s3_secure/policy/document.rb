class S3Secure::Policy
  class Document
    extend Memoist

    delegate :has?, to: :checker

    def initialize(bucket, bucket_policy, remove: false)
      @bucket, @bucket_policy, @remove = bucket, bucket_policy, remove # existing document policy
    end

    # Returns JSON text
    # Currently only support adding ForceSSLOnlyAccess document policy.
    def policy_document(sid, remove: false)
      enforcer_class = "S3Secure::Policy::Document::#{sid}"
      enforcer_class += "Remove" if @remove
      enforcer_class = enforcer_class.constantize # IE: ForceSSLOnlyAccess
      enforcer = enforcer_class.new(@bucket, @bucket_policy)
      policy = enforcer.policy_document
      JSON.pretty_generate(policy) if policy
    end

    def checker
      Checker.new(@bucket_policy)
    end
    memoize :checker
  end
end
