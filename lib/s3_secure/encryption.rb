module S3Secure
  class Encryption < Command
    desc "list", "List bucket encryptions"
    long_desc Help.text("encryption/list")
    def list
      List.new(options).run
    end

    desc "show BUCKET", "show bucket encryption"
    long_desc Help.text("encryption/show")
    def show(bucket)
      Show.new(options.merge(bucket: bucket)).run
    end

    desc "enable BUCKET", "enable bucket encryption"
    long_desc Help.text("encryption/enable")
    option :kms_key, desc: "KMS Key Id. If this is set will use sse_algorithm=aws:kms Otherwise will use sse_algorithm=AES256"
    def enable(bucket)
      Enable.new(options.merge(bucket: bucket)).run
    end

    desc "disable BUCKET", "disable bucket encryption"
    long_desc Help.text("encryption/disable")
    def disable(bucket)
      Disable.new(options.merge(bucket: bucket)).run
    end
  end
end
