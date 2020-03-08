class S3Secure::Encryption
  class List < Base
    def run
      presenter = CliFormat::Presenter.new(@options)
      presenter.header = ["Bucket", "Has Encryption?"]

      buckets.each do |bucket|
        @s3 = s3_regional_client(bucket)
        $stderr.puts "Getting encryption for bucket #{bucket.color(:green)}"
        encryption_rules = get_encryption_rules(bucket)

        row = [bucket, !!encryption_rules]
        if @options[:encryption].nil?
          presenter.rows << row # always show policy
        elsif @options[:encryption]
          presenter.rows << row if encryption_rules # only show if bucket has some encryption rules
        else
          presenter.rows << row unless encryption_rules # only show if bucket doesnt have any encryption rules
        end
      end

      presenter.show
    end

    def get_encryption_rules(bucket)
      resp = @s3.get_bucket_encryption(bucket: bucket)
      resp.server_side_encryption_configuration.rules # Aws::Xml::DefaultList object
    rescue Aws::S3::Errors::ServerSideEncryptionConfigurationNotFoundError
    end

    # Useful when calling List outside of the list CLI
    def set_s3(client)
      @s3 = client
    end
  end
end
