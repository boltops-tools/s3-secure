module S3Secure::Versioning
  class List < Base
    def run
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = ["Bucket", "Has Versioning?"]

      buckets.each do |bucket|
        $stderr.puts "Getting versioning for bucket #{bucket.color(:green)}"

        show = Show.new(bucket: bucket)
        row = [bucket, show.enabled?]
        if @options[:versioning].nil?
          presenter.rows << row # always show policy
        elsif @options[:versioning]
          presenter.rows << row if show.enabled? # only show if bucket has some encryption rules
        else
          presenter.rows << row unless show.enabled? # only show if bucket doesnt have any encryption rules
        end
      end

      presenter.show
    end
  end
end
