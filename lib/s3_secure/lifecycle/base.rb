module S3Secure::Lifecycle
  class Base < S3Secure::CLI::Base
    RULE_ID = "s3-secure-automated-cleanup"
  end
end
