class S3Secure::Policy
  class List < Base
    def run
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = ["Bucket", "Has Policy?"]

      buckets.each do |bucket|
        @s3 = s3_regional_client(bucket)
        $stderr.puts "Getting policy for bucket #{bucket.color(:green)}"
        policy = get_policy(bucket)

        row = [bucket, !!policy]
        if @options[:policy].nil?
          presenter.rows << row # always show policy
        elsif @options[:policy]
          presenter.rows << row if policy # only show if bucket has a policy
        else
          presenter.rows << row unless policy # only show if bucket doesnt have a policy
        end
      end

      presenter.show
    end

    def get_policy(bucket)
      resp = @s3.get_bucket_policy(bucket: bucket)
      data = JSON.load(resp.policy.read) # String
      JSON.pretty_generate(data)
    rescue Aws::S3::Errors::NoSuchBucketPolicy
    end

    # Useful when calling List outside of the list CLI
    def set_s3(client)
      @s3 = client
    end
  end
end
