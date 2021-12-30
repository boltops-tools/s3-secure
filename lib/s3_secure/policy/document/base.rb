class S3Secure::Policy::Document
  class Base
    extend Memoist

    def initialize(bucket, bucket_policy)
      # @bucket_policy is existing document policy
      @bucket, @bucket_policy = bucket, bucket_policy
    end

    def checker
      S3Secure::Policy::Checker.new(@bucket_policy)
    end
    memoize :checker
  end
end
