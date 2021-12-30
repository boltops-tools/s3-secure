module S3Secure
  module BackwardsCompatibility
  end

  module Encryption
    CLI::Encryption::Enable = Encryption::Enable
  end
  module Policy
    CLI::Policy::Enforce = Policy::Enforce
  end
  module Versioning
    CLI::Versioning::Enable = Versioning::Enable
  end
  module Lifecycle
    CLI::Lifecycle::Add = Lifecycle::Add
  end
  module AccessLogs
    CLI::AccessLogs::Enable = AccessLogs::Enable
  end
end
