module S3Secure::Encryption
  class List < Base
    def run
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = ["Bucket", "Has Encryption?"]

      buckets.each do |bucket|
        $stderr.puts "Getting encryption for bucket #{bucket.color(:green)}"
        show = Show.new(bucket: bucket)

        row = [bucket, show.enabled?]
        if @options[:encryption].nil?
          presenter.rows << row # always show policy
        elsif @options[:encryption]
          presenter.rows << row if show.enabled? # only show if bucket has some encryption rules
        else
          presenter.rows << row unless show.enabled? # only show if bucket doesnt have any encryption rules
        end
      end

      presenter.show
    end
  end
end
