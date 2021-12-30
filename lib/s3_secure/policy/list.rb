module S3Secure::Policy
  class List < Base
    def run
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = ["Bucket", "Has Policy?"]

      buckets.each do |bucket|
        $stderr.puts "Getting policy for bucket #{bucket.color(:green)}"
        show = Show.new(bucket: bucket)
        policy = show.policy

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
  end
end
