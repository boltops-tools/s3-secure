module S3Secure::PublicAccess
  class Base < S3Secure::CLI::Base
    extend Memoist

    def account_id
      sts.get_caller_identity.account
    end
    memoize :account_id
  end
end
