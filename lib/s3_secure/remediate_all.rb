module S3Secure
  class RemediateAll < AbstractBase
    def run
      Encryption::Enable.new(bucket: @bucket).run
      Policy::Enforce.new(bucket: @bucket, sid: "ForceSSLOnlyAccess").run
      Versioning::Enable.new(bucket: @bucket).run
      Lifecycle::Add.new(bucket: @bucket).run
      AccessLogs::Enable.new(bucket: @bucket).run
    end
  end
end
