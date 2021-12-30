class S3Secure::CLI
  class Summary < Base
    def run
      $stderr.puts("Determining bucket security-related settings. Can take a while for lots of buckets...")
      data = [%w[Bucket SSL? Encrypted?]]
      items = S3Secure::Summary::Items.new(@options, buckets)
      items.filtered_items.each do |i|
        data << [i.bucket, i.ssl, i.encrypted]
      end
      S3Secure::Table.new(@options, data).display
    end
  end
end
