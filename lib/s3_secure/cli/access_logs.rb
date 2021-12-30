class S3Secure::CLI
  class AccessLogs < S3Secure::Command
    class_option :quiet, type: :boolean

    desc "list", "List bucket access_logs setting"
    long_desc Help.text("access_logs/list")
    option :format, desc: "Format options: #{CliFormat.formats.join(', ')}"
    option :access_logs, type: :boolean, desc: "Filter for access_logs: all, true, false"
    def list
      S3Secure::AccessLogs::List.new(options).run
    end

    desc "show BUCKET", "show bucket access_logs"
    long_desc Help.text("access_logs/show")
    def show(bucket)
      S3Secure::AccessLogs::Show.new(options.merge(bucket: bucket)).run
    end

    desc "enable BUCKET", "enable bucket access_logs"
    long_desc Help.text("access_logs/enable")
    option :target_bucket, desc: "Target s3 bucket"
    def enable(bucket)
      S3Secure::AccessLogs::Enable.new(options.merge(bucket: bucket)).run
    end

    desc "disable BUCKET", "disable bucket access_logs"
    long_desc Help.text("access_logs/disable")
    def disable(bucket)
      S3Secure::AccessLogs::Disable.new(options.merge(bucket: bucket)).run
    end
  end
end
