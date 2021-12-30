class S3Secure::CLI
  class Versioning < S3Secure::Command
    class_option :quiet, type: :boolean

    desc "list", "List bucket versionings"
    long_desc Help.text("versioning/list")
    option :format, desc: "Format options: #{CliFormat.formats.join(', ')}"
    option :versioning, desc: "Filter for versioning: all, true, false"
    def list
      S3Secure::Versioning::List.new(options).run
    end

    desc "show BUCKET", "show bucket versioning"
    long_desc Help.text("versioning/show")
    def show(bucket)
      S3Secure::Versioning::Show.new(options.merge(bucket: bucket)).run
    end

    desc "enable BUCKET", "enable bucket versioning"
    long_desc Help.text("versioning/enable")
    def enable(bucket)
      S3Secure::Versioning::Enable.new(options.merge(bucket: bucket)).run
    end

    desc "disable BUCKET", "disable bucket versioning"
    long_desc Help.text("versioning/disable")
    def disable(bucket)
      S3Secure::Versioning::Disable.new(options.merge(bucket: bucket)).run
    end
  end
end
