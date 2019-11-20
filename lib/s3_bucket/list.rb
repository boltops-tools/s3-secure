module S3Bucket
  class List < Command
    desc "policy", "List bucket policies"
    long_desc Help.text(:policy)
    def policy
      Policy.new(options).run
    end

    desc "encryption", "List bucket encryptions"
    long_desc Help.text(:encryption)
    def encryption
      Encryption.new(options).run
    end
  end
end
