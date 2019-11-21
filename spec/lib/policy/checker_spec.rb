describe S3Secure::Policy::Checker do
  subject { S3Secure::Policy::Checker.new(policy_json) }

  describe "already has ForceSslOnlyAccess" do
    let(:policy_json) {
      <<~JSON
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "ForceSslOnlyAccess",
                    "Effect": "Deny",
                    "Principal": "*",
                    "Action": "s3:GetObject",
                    "Resource": "arn:aws:s3:::my-test-s3-secure-us-east-1/*",
                    "Condition": {
                        "Bool": {
                            "aws:SecureTransport": "false"
                        }
                    }
                }
            ]
        }
      JSON
    }

    it "has?" do
      result = subject.has?("ForceSslOnlyAccess")
      expect(result).to be true
    end
  end

  describe "doesnt have ForceSslOnlyAccess" do
    let(:policy_json) {
      <<~JSON
        {
          "Version": "2008-10-17",
          "Id": "PolicyForCloudFrontPrivateContent",
          "Statement": [
            {
              "Sid": "1",
              "Effect": "Allow",
              "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E27G6OAEXAMPLE"
              },
              "Action": "s3:GetObject",
              "Resource": "arn:aws:s3:::test-fake-website/*"
            }
          ]
        }
      JSON
    }

    it "has?" do
      result = subject.has?("ForceSslOnlyAccess")
      expect(result).to be false
    end
  end

  describe "empty policy" do
    let(:policy_json) { nil }

    it "has?" do
      result = subject.has?("ForceSslOnlyAccess")
      expect(result).to be false
    end
  end
end
