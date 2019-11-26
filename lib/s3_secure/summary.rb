module S3Secure
  class Summary < AbstractBase
    def run
      $stderr.puts("Determing bucket security-related settings...")
      data = [%w[Bucket SSL? Encrypted?]]
      items = Items.new(@options, buckets)
      items.filtered_items.each do |i|
        data << [i.bucket, i.ssl, i.encrypted]
      end
      S3Secure::Table.new(@options, data).display
    end
  end
end
