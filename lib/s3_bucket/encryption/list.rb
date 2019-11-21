class S3Bucket::Encryption
  class List < Base
    def run
      buckets.each do |bucket|
        @s3 = s3_regional_client(bucket)
        puts "Policy for bucket #{bucket.color(:green)}"
        encryption_rules = get_encryption_rules(bucket)

        if encryption_rules
          puts encryption_rules
        else
          puts "Bucket does not have bucket encryption enabled"
        end
      end
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
