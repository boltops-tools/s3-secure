class S3Secure::CLI
  class Encryption < S3Secure::Command
    class_option :quiet, type: :boolean

    desc "list", "List bucket encryptions"
    long_desc Help.text("encryption/list")
    option :format, desc: "Format options: #{CliFormat.formats.join(', ')}"
    option :encryption, type: :boolean, desc: "Filter for encryption: all, true, false"
    def list
      S3Secure::Encryption::List.new(options).run
    end

    desc "show BUCKET", "show bucket encryption"
    long_desc Help.text("encryption/show")
    def show(bucket)
      S3Secure::Encryption::Show.new(options.merge(bucket: bucket)).run
    end

    desc "enable BUCKET", "enable bucket encryption"
    long_desc Help.text("encryption/enable")
    option :kms_key, desc: "KMS Key Id. If this is set will use sse_algorithm=aws:kms Otherwise will use sse_algorithm=AES256"
    def enable(bucket)
      S3Secure::Encryption::Enable.new(options.merge(bucket: bucket)).run
    end

    desc "disable BUCKET", "disable bucket encryption"
    long_desc Help.text("encryption/disable")
    def disable(bucket)
      S3Secure::Encryption::Disable.new(options.merge(bucket: bucket)).run
    end
  end
end
