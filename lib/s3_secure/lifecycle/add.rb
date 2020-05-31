class S3Secure::Lifecycle
  class Add < Base
    RULE_ID = Base::RULE_ID

    def run
      show = Show.new(@options)
      if @options[:additive]
        current_rules = show.get_lifecycle_rules(@bucket)
        builder = Builder.new(current_rules)
        rules = builder.rules_with_addition(@options[:prefix])
        if current_rules.size == rules.size
          puts "WARN: rule wasnt added because a #{RULE_ID} already exists".color(:yellow)
        else
          s3.put_bucket_lifecycle_configuration(
            bucket: @bucket, # required
            lifecycle_configuration: {rules: rules}
          )
        end
      elsif show.any?
        puts "Bucket #{@bucket} is has a lifecycle policy already."
        return
      else
        options = {
          bucket: @bucket, # required
          lifecycle_configuration: {rules: [Builder::DEFAULT_RULE]}
        }
        s3.put_bucket_lifecycle_configuration(options)
      end

      puts "Added lifecycle policy to bucket #{@bucket}"
    end
  end
end
