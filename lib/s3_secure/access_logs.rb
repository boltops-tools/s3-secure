module S3Secure
  class AccessLogs < Command
    desc "list", "List bucket access_logs setting"
    long_desc Help.text("access_logs/list")
    option :format, desc: "Format options: #{CliFormat.formats.join(', ')}"
    option :access_logs, type: :boolean, desc: "Filter for access_logs: all, true, false"
    def list
      List.new(options).run
    end

    desc "show BUCKET", "show bucket access_logs"
    long_desc Help.text("access_logs/show")
    def show(bucket)
      Show.new(options.merge(bucket: bucket)).run
    end

    desc "enable BUCKET", "enable bucket access_logs"
    long_desc Help.text("access_logs/enable")
    option :target_bucket, desc: "Target s3 bucket"
    def enable(bucket)
      Enable.new(options.merge(bucket: bucket)).run
    end

    desc "disable BUCKET", "disable bucket access_logs"
    long_desc Help.text("access_logs/disable")
    def disable(bucket)
      Disable.new(options.merge(bucket: bucket)).run
    end
  end
end
