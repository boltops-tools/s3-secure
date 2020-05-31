module S3Secure
  class Lifecycle < Command
    desc "list", "List bucket lifecycles"
    long_desc Help.text("lifecycle/list")
    option :format, desc: "Format options: #{CliFormat.formats.join(', ')}"
    option :lifecycle, desc: "Filter for lifecycle: all, true, false"
    def list
      List.new(options).run
    end

    desc "show BUCKET", "show bucket lifecycle"
    long_desc Help.text("lifecycle/show")
    def show(bucket)
      Show.new(options.merge(bucket: bucket)).run
    end

    desc "add BUCKET", "add bucket lifecycle"
    long_desc Help.text("lifecycle/add")
    option :additive, type: :boolean, desc: "Force adding another lifecycle rule even if one exists. Note, may fail, need a different prefix filter"
    option :prefix, desc: "Filter prefix. Used with additive mode."
    def add(bucket)
      Add.new(options.merge(bucket: bucket)).run
    end

    desc "remove BUCKET", "remove bucket lifecycle"
    long_desc Help.text("lifecycle/remove")
    def remove(bucket)
      Remove.new(options.merge(bucket: bucket)).run
    end
  end
end
