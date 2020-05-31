class S3Secure::Summary
  class Items < S3Secure::AbstractBase
    extend Memoist

    # override initialize
    def initialize(options, buckets)
      @options, @buckets = options, buckets
      @ssl, @encrypted = @options[:ssl], @options[:encrypted]
    end

    def filtered_items
      items = all_items.select do |item|
        case @ssl
        when "yes", "no"
          @ssl == item.ssl
        else # any or fallback
          true
        end
      end

      items.select do |item|
        case @encrypted
        when "yes", "no"
          @encrypted == item.encrypted
        else # any or fallback
          true
        end
      end
    end

    # Triggers loading of items
    def all_items
      load_items!
    end

    def load_items!
      @buckets.map do |bucket|
        Item.new(bucket,
                 ssl: ssl?(bucket) ? "yes" : "no",
                 encrypted: encrypted?(bucket) ? "yes" : "no")
      end
    end
    memoize :load_items!

  private
    def ssl?(bucket)
      list = S3Secure::Policy::List.new(@options)

      bucket_policy = list.get_policy(bucket)
      document = S3Secure::Policy::Document.new(bucket, bucket_policy)
      document.has?("ForceSSLOnlyAccess")
    end
    memoize :ssl?

    def encrypted?(bucket)
      s3 = s3_regional_client(bucket)
      list = S3Secure::Encryption::List.new(@options)
      list.set_s3(s3)

      rules = list.get_encryption_rules(bucket)
      !!rules
    end
    memoize :encrypted?
  end
end
