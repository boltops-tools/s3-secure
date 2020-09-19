module S3Secure
  module Say
    def say(msg)
      puts msg unless @options[:quiet]
    end
  end
end
