class S3Secure::CLI
  class PublicAccess < S3Secure::Command
    class_option :quiet, type: :boolean

    desc "list", "List bucket public access policy"
    long_desc Help.text("public_access/list")
    option :format, desc: "Format options: #{CliFormat.formats.join(', ')}"
    option :blocked, desc: "Filter for public_access: all, true, false"
    def list
      S3Secure::PublicAccess::List.new(options).run
    end

    desc "show BUCKET", "show bucket public_access"
    long_desc Help.text("public_access/show")
    def show(bucket)
      S3Secure::PublicAccess::Show.new(options.merge(bucket: bucket)).run
    end

    desc "block BUCKET", "block bucket public_access"
    long_desc Help.text("public_access/block")
    option :prefix, desc: "Filter prefix. Used with mode."
    def block(bucket)
      S3Secure::PublicAccess::Block.new(options.merge(bucket: bucket)).run
    end

    desc "unblock BUCKET", "unblock bucket public_access"
    long_desc Help.text("public_access/unblock")
    def unblock(bucket)
      S3Secure::PublicAccess::Unblock.new(options.merge(bucket: bucket)).run
    end
  end
end
