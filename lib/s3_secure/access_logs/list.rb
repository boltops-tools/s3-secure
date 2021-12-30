module S3Secure::AccessLogs
  class List < Base
    def run
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = ["Bucket", "Access Logs?"]

      buckets.each do |bucket|
        $stderr.puts "Getting access log setting for bucket #{bucket.color(:green)}"
        show = Show.new(bucket: bucket)

        enabled = show.logging_enabled?
        row = [bucket, enabled]
        if @options[:enabled].nil?
          presenter.rows << row # always show policy
        elsif @options[:enabled]
          presenter.rows << row if enabled # only show if bucket has some encryption rules
        else
          presenter.rows << row unless enabled # only show if bucket doesnt have any encryption rules
        end
      end

      presenter.show
    end
  end
end
