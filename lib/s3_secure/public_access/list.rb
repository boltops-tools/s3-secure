module S3Secure::PublicAccess
  class List < Base
    def run
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = ["Bucket", "Block Public Access?"]

      buckets.each do |bucket|
        say "Getting bucket public access configuration for bucket #{bucket.color(:green)}"

        blocked = Show.new(bucket: bucket).blocked?
        row = [bucket, blocked]
        if @options[:blocked].nil?
          presenter.rows << row # always show policy
        elsif @options[:blocked]
          presenter.rows << row if blocked # only show if bucket is blocked
        else
          presenter.rows << row unless blocked # only show if bucket is unblocked
        end
      end

      presenter.show
    end
  end
end
