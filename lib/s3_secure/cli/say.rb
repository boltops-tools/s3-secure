class S3Secure::CLI
  module Say
    def say(msg)
      puts msg unless @options[:quiet]
    end
  end
end
