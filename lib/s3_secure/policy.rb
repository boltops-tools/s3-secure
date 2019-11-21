module S3Secure
  class Policy < Command
    desc "list", "List bucket policies"
    long_desc Help.text("policy/list")
    def list
      List.new(options).run
    end

    desc "show BUCKET", "show bucket policy"
    long_desc Help.text("policy/show")
    def show(bucket)
      Show.new(options.merge(bucket: bucket)).run
    end

    desc "enable BUCKET", "enable bucket policy"
    long_desc Help.text("policy/enable")
    def enable(bucket)
      Enable.new(options.merge(bucket: bucket)).run
    end

    desc "disable BUCKET", "disable bucket policy"
    long_desc Help.text("policy/disable")
    def disable(bucket)
      Disable.new(options.merge(bucket: bucket)).run
    end
  end
end
