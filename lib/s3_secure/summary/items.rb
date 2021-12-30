module S3Secure::Summary
  class Items < S3Secure::CLI::Base
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
      show = S3Secure::Policy::Show.new(@options.merge(bucket: bucket))

      bucket_policy = show.run
      document = S3Secure::Policy::Document.new(bucket, bucket_policy)
      document.has?("ForceSSLOnlyAccess")
    end
    memoize :ssl?

    def encrypted?(bucket)
      s3 = s3_regional_client(bucket)
      show = S3Secure::Encryption::Show.new(@options.merge(bucket: bucket))

      rules = show.run
      !!rules
    end
    memoize :encrypted?
  end
end
