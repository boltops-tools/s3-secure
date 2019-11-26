module S3Secure
  class Summary < AbstractBase
    def run
      $stderr.puts("Determing bucket security-related settings...")
      data = []
      data << %w[Bucket SSL? Encrypted?]
      buckets.each do |bucket|
        ssl, encrypted = ssl?(bucket), encrypted?(bucket)
        data << [bucket, ssl, encrypted]
      end
      S3Secure::Table.new(@options, data).display
    end

    def ssl?(bucket)
      s3 = s3_regional_client(bucket)
      list = S3Secure::Policy::List.new(@options)
      list.set_s3(s3)

      bucket_policy = list.get_policy(bucket)
      document = S3Secure::Policy::Document.new(bucket, bucket_policy)
      document.has?("ForceSSLOnlyAccess")
    end

    def encrypted?(bucket)
      s3 = s3_regional_client(bucket)
      list = S3Secure::Encryption::List.new(@options)
      list.set_s3(s3)

      rules = list.get_encryption_rules(bucket)
      !!rules
    end
  end
end
