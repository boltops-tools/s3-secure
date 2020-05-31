describe S3Secure::Lifecycle::Builder do
  subject { S3Secure::Lifecycle::Builder.new(rules) }

  describe "already has s3-secure-automated-cleanup rule" do
    let(:rules) {
      [{:expiration=>{:expired_object_delete_marker=>true},
        :id=>"s3-secure-automated-cleanup",
        :status=>"Enabled",
        :noncurrent_version_expiration=>{:noncurrent_days=>365},
        :abort_incomplete_multipart_upload=>{:days_after_initiation=>30}}]
    }

    it "has?" do
      result = subject.has?("s3-secure-automated-cleanup")
      expect(result).to be true
    end

    it "rules_with_addition" do
      rules = subject.rules_with_addition
      expect(rules.size).to eq 1 # no dups
      result = has_lifecycle?(rules)
      expect(result).to be true
    end

    it "rules_with_removal" do
      rules = subject.rules_with_removal
      result = has_lifecycle?(rules)
      expect(result).to be false
    end
  end

  describe "doesnt have s3-secure-automated-cleanup rule" do
    let(:rules) {
      [{:rules=>
        [{:expiration=>{:expired_object_delete_marker=>true},
          :id=>"someother-policy",
          :status=>"Enabled",
          :noncurrent_version_expiration=>{:noncurrent_days=>365},
          :abort_incomplete_multipart_upload=>{:days_after_initiation=>30}}]}]
    }

    it "has?" do
      result = subject.has?("s3-secure-automated-cleanup")
      expect(result).to be false
    end

    it "rules_with_addition" do
      rules = subject.rules_with_addition
      expect(rules.size).to eq 2 # no dups
      result = has_lifecycle?(rules)
      expect(result).to be true
    end

    it "rules_with_removal" do
      rules = subject.rules_with_removal
      result = has_lifecycle?(rules)
      expect(result).to be false
    end
  end

  describe "empty policy" do
    let(:rules) { nil }

    it "has?" do
      result = subject.has?("s3-secure-automated-cleanup")
      expect(result).to be false
    end

    it "rules_with_addition" do
      rules = subject.rules_with_addition
      result = has_lifecycle?(rules)
      expect(result).to be true
    end

    it "rules_with_removal" do
      rules = subject.rules_with_removal
      result = has_lifecycle?(rules)
      expect(result).to be false
    end
  end

  def has_lifecycle?(rules)
    !!rules.detect { |rule| rule[:id] == S3Secure::Lifecycle::Builder::RULE_ID }
  end
end
