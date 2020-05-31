module S3Secure
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "access_logs SUBCOMMAND", "access_logs subcommands"
    long_desc Help.text(:access_logs)
    subcommand "access_logs", AccessLogs

    desc "encryption SUBCOMMAND", "encryption subcommands"
    long_desc Help.text(:encryption)
    subcommand "encryption", Encryption

    desc "policy SUBCOMMAND", "policy subcommands"
    long_desc Help.text(:policy)
    subcommand "policy", Policy

    desc "versioning SUBCOMMAND", "versioning subcommands"
    long_desc Help.text(:versioning)
    subcommand "versioning", Versioning

    desc "lifecycle SUBCOMMAND", "lifecycle subcommands"
    long_desc Help.text(:lifecycle)
    subcommand "lifecycle", Lifecycle

    desc "remediate_all", "Remediate all. For more fine-grain control use each of the commands directly."
    long_desc Help.text("remediate_all")
    def remediate_all(bucket)
      RemediateAll.new(options.merge(bucket: bucket)).run
    end

    desc "summary", "Summarize buckets"
    long_desc Help.text("summary")
    option :encrypted, default: "any", desc: "filter for encryption enabled. Examples: any, yes, no"
    option :ssl, default: "any", desc: "filter for ssl enforcement. Examples: any, yes, no"
    def summary
      Summary.new(options).run
    end

    desc "batch *PARAMS", "Batch wrapper method"
    long_desc Help.text(:batch)
    def batch(*params)
      Batch.new(*params).run
    end

    desc "completion *PARAMS", "Prints words for auto-completion."
    long_desc Help.text(:completion)
    def completion(*params)
      Completer.new(CLI, *params).run
    end

    desc "completion_script", "Generates a script that can be eval to setup auto-completion."
    long_desc Help.text(:completion_script)
    def completion_script
      Completer::Script.generate
    end

    desc "version", "prints version"
    def version
      puts VERSION
    end
  end
end
