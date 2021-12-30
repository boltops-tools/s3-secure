module S3Secure::Lifecycle
  class Show < Base
    RULE_ID = Base::RULE_ID

    def run
      if any?
        say "This S3 bucket has lifecycle rules"
      else
        say "This S3 bucket does not have lifecycle rules"
      end

      if any?
        say "Bucket lifecycle details: "
        pp get_lifecycle(@bucket).to_h
      end
    end

    def any?
      rules = get_lifecycle_rules(@bucket)
      !!(rules && !rules.empty?)
    end

    def has?(rule_id)
      rules = get_lifecycle_rules(@bucket)
      rules && rules.detect { |rule| rule[:id] == rule_id }
    end

    def get_lifecycle(bucket)
      s3.get_bucket_lifecycle_configuration(bucket: bucket) # resp
    rescue Aws::S3::Errors::NoSuchLifecycleConfiguration
    end
    memoize :get_lifecycle

    # Also used by add and remove
    def get_lifecycle_rules(bucket)
      resp = get_lifecycle(bucket)
      resp.rules.map(&:to_h) if resp
    end
  end
end
