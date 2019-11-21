module S3Bucket
  class Policy < Command
    desc "list", "List bucket policies"
    long_desc Help.text("policy/list")
    def list
      List.new(options).run
    end

    desc "show", "show bucket policy"
    long_desc Help.text("policy/show")
    def show
      Show.new(options).run
    end

    desc "enable", "enable bucket policy"
    long_desc Help.text("policy/enable")
    def enable
      Enable.new(options).run
    end

    desc "disable", "disable bucket policy"
    long_desc Help.text("policy/disable")
    def disable
      Disable.new(options).run
    end
  end
end
