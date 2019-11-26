class S3Secure::Summary
  class Item
    attr_reader :bucket
    def initialize(bucket, properties={})
      @bucket, @properties = bucket, properties
    end

    def method_missing(name, *args, &block)
      if @properties.key?(name)
        @properties[name]
      else
        super
      end
    end
  end
end
