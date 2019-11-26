## Example

    $ s3-secure policy enforce_ssl a-test-bucket-in-us-east-1
    Add bucket policy to bucket a-test-bucket-in-us-east-1:
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
    $