module S3Secure::Lifecycle
  class Remove < Base
    RULE_ID = Base::RULE_ID

    def run
      show = Show.new(@options)
      unless show.has?(RULE_ID)
        say "Bucket #{@bucket} already does not have the #{RULE_ID} lifecycle rule."
        return
      end

      builder = Builder.new(show.get_lifecycle_rules(@bucket))
      rules = builder.rules_with_removal
      if rules.empty?
        s3.delete_bucket_lifecycle(bucket: @bucket)
      else
        # update config with removal
        s3.put_bucket_lifecycle_configuration(
          bucket: @bucket, # required
          # content_md5: "ContentMD5",
          lifecycle_configuration: {rules: rules}
        )
      end

      say "Removed the #{RULE_ID} lifecycle rule on bucket #{@bucket}"
    end
  end
end
