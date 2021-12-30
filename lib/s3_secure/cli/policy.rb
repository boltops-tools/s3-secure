class S3Secure::CLI
  class Policy < S3Secure::Command
    class_option :quiet, type: :boolean

    desc "list", "List bucket policies"
    long_desc Help.text("policy/list")
    option :format, desc: "Format options: #{CliFormat.formats.join(', ')}"
    option :policy, type: :boolean, desc: "Filter for policy: all, true, false"
    def list
      S3Secure::Policy::List.new(options).run
    end

    desc "show BUCKET", "show bucket policy"
    long_desc Help.text("policy/show")
    def show(bucket)
      S3Secure::Policy::Show.new(options.merge(bucket: bucket)).run
    end

    desc "enforce_ssl BUCKET", "Add enforce ssl bucket policy"
    long_desc Help.text("policy/enforce_ssl")
    def enforce_ssl(bucket)
      S3Secure::Policy::Enforce.new(options.merge(bucket: bucket, sid: "ForceSSLOnlyAccess")).run
    end

    desc "unforce_ssl BUCKET", "Remove enforce ssl bucket policy"
    long_desc Help.text("policy/unforce_ssl")
    def unforce_ssl(bucket)
      S3Secure::Policy::Unforce.new(options.merge(bucket: bucket, sid: "ForceSSLOnlyAccess")).run
    end
  end
end
