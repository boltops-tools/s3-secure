class S3Secure::CLI
  class RemediateAll < Base
    def run
      o = @options.merge(bucket: @bucket)
      Encryption::Enable.new(o).run
      Policy::Enforce.new(o.merge(sid: "ForceSSLOnlyAccess")).run
      Versioning::Enable.new(o).run
      Lifecycle::Add.new(o).run
      AccessLogs::Enable.new(o).run
    end
  end
end
