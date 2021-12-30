module S3Secure::Lifecycle
  class Builder
    # Note: put_bucket_lifecycle_configuration and put_bucket_lifecycle understand different payloads.
    # put_bucket_lifecycle is old and shouldnt be used
    RULE_ID = Base::RULE_ID
    DEFAULT_RULE = {
      expiration: {expired_object_delete_marker: true},
      id: RULE_ID,
      status: "Enabled",
      prefix: "",
      noncurrent_version_expiration: {noncurrent_days: 365},
      abort_incomplete_multipart_upload: {days_after_initiation: 30}
    }

    def initialize(rules)
      @rules = rules || []
    end

    def has?(id)
      !!@rules.detect { |rule| rule[:id] == id }
    end

    def rules_with_addition(prefix=nil)
      rules = @rules.dup
      unless has?(RULE_ID)
        rule = DEFAULT_RULE
        rule[:prefix] = prefix if prefix
        rules << rule
      end
      rules
    end

    def rules_with_removal
      rules = @rules.dup
      rules.delete_if { |rule| rule[:id] == RULE_ID }
      rules
    end

    def build(type)
      if type == :remove
        remove_lifecycle
      else
        add_lifecycle
      end
    end
  end
end
