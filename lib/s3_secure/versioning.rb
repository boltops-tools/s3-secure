module S3Secure
  class Versioning < Command
    class_option :quiet, type: :boolean

    desc "list", "List bucket versionings"
    long_desc Help.text("versioning/list")
    option :format, desc: "Format options: #{CliFormat.formats.join(', ')}"
    option :versioning, desc: "Filter for versioning: all, true, false"
    def list
      List.new(options).run
    end

    desc "show BUCKET", "show bucket versioning"
    long_desc Help.text("versioning/show")
    def show(bucket)
      Show.new(options.merge(bucket: bucket)).run
    end

    desc "enable BUCKET", "enable bucket versioning"
    long_desc Help.text("versioning/enable")
    def enable(bucket)
      Enable.new(options.merge(bucket: bucket)).run
    end

    desc "disable BUCKET", "disable bucket versioning"
    long_desc Help.text("versioning/disable")
    def disable(bucket)
      Disable.new(options.merge(bucket: bucket)).run
    end
  end
end
