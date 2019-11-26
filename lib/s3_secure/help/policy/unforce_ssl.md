## Example

If the policy only has the ForceSSLOnlyAccess statement, then the entire bucket policy is removed:

    $ s3-secure policy unforce_ssl a-test-bucket-in-us-west-1
    Remove bucket policy to bucket a-test-bucket-in-us-west-1:
    $

If the policy has other statements, then only the ForceSSLOnlyAccess is removed any other policies are kept in tact.

    $ s3-secure policy show a-test-bucket-in-us-east-1
    Bucket a-test-bucket-in-us-east-1 is configured with this policy:
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "IPAllow",
          "Effect": "Deny",
          "Principal": "*",
          "Action": "s3:*",
          "Resource": "arn:aws:s3:::a-test-bucket-in-us-east-1/*",
          "Condition": {
            "NotIpAddress": {
              "aws:SourceIp": "54.240.143.0/24"
            }
          }
        },
        {
          "Sid": "ForceSSLOnlyAccess",
          "Effect": "Deny",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::a-test-bucket-in-us-east-1/*",
          "Condition": {
            "Bool": {
              "aws:SecureTransport": "false"
            }
          }
        }
      ]
    }
    $ s3-secure policy unforce_ssl a-test-bucket-in-us-east-1
    Remove bucket policy statement from bucket a-test-bucket-in-us-east-1:
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "IPAllow",
          "Effect": "Deny",
          "Principal": "*",
          "Action": "s3:*",
          "Resource": "arn:aws:s3:::a-test-bucket-in-us-east-1/*",
          "Condition": {
            "NotIpAddress": {
              "aws:SourceIp": "54.240.143.0/24"
            }
          }
        }
      ]
    }
    $