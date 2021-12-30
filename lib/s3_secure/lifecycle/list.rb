module S3Secure::Lifecycle
  class List < Base
    def run
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = ["Bucket", "Has Lifecycle Rules?"]

      buckets.each do |bucket|
        $stderr.puts "Getting lifecycle policy for bucket #{bucket.color(:green)}"

        show = Show.new(bucket: bucket)
        row = [bucket, show.any?]
        if @options[:lifecycle].nil?
          presenter.rows << row # always show policy
        elsif @options[:lifecycle]
          presenter.rows << row if status # only show if bucket has some encryption rules
        else
          presenter.rows << row unless status # only show if bucket doesnt have any encryption rules
        end
      end

      presenter.show
    end
  end
end
