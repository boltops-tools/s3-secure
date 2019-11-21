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

    desc "enforce_ssl BUCKET", "Add enforce ssl bucket policy"
    long_desc Help.text("policy/enforce_ssl")
    def enforce_ssl(bucket)
      Enforce.new(options.merge(bucket: bucket, sid: "ForceSslOnlyAccess")).run
    end

    desc "unforce_ssl BUCKET", "Remove enforce ssl bucket policy"
    long_desc Help.text("policy/unforce_ssl")
    def unforce_ssl(bucket)
      Unforce.new(options.merge(bucket: bucket, sid: "ForceSslOnlyAccess")).run
    end
  end
end
