module S3Secure
  class Policy < Command
    desc "list", "List bucket policies"
    long_desc Help.text("policy/list")
    option :format, desc: "Format options: #{CliFormat.formats.join(', ')}"
    option :policy, type: :boolean, desc: "Filter for has policy: all, true, false"
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
      Enforce.new(options.merge(bucket: bucket, sid: "ForceSSLOnlyAccess")).run
    end

    desc "unforce_ssl BUCKET", "Remove enforce ssl bucket policy"
    long_desc Help.text("policy/unforce_ssl")
    def unforce_ssl(bucket)
      Unforce.new(options.merge(bucket: bucket, sid: "ForceSSLOnlyAccess")).run
    end
  end
end
