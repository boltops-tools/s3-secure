# s3-secure tool

[![Gem Version](https://badge.fury.io/rb/s3-secure.png)](http://badge.fury.io/rb/s3-secure)]
[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

The s3-secure tool can be used to harden your s3 bucket security posture. The tool is useful if you have a lot of buckets to update. It supports:

* access logs: enabling access logs
* encryption: enabling encryption
* ssl bucket policy: adding an enforce ssl bucket policy
* versioning: enabling bucket versioning

## BoltOps Pro Related Blueprints

* [S3 Secure](https://github.com/boltopspro-docs/s3-secure): Continuously Auto-Remediates New Buckets.
* [Security Controls](https://github.com/boltopspro-docs/security-controls): Continuously applies the s3-secure remedations as well as other remeidations. IE: Security Groups, SNS topics, etc.

## Usage

Summary of encryption commands:

    s3-secure encryption list
    s3-secure encryption show BUCKET
    s3-secure encryption enable BUCKET
    s3-secure encryption disable BUCKET

Summary of lifecycle commands:

    s3-secure lifecycle list
    s3-secure lifecycle show BUCKET
    s3-secure lifecycle add BUCKET
    s3-secure lifecycle remove BUCKET

Summary of policy commands:

    s3-secure policy list
    s3-secure policy show BUCKET
    s3-secure policy enforce_ssl BUCKET
    s3-secure policy unforce_ssl BUCKET

Summary of versioning commands:

    s3-secure versioning list
    s3-secure versioning show BUCKET
    s3-secure versioning enable BUCKET
    s3-secure versioning disable BUCKET

## Remediate All

To apply all the remeidations:

    s3-secure remediate_all BUCKET

For finer-control, run each subcommand instead.

## Some Examples with Output

Example of `s3-secure encryption enable`:

    $ s3-secure encryption enable a-test-bucket-in-us-west-1
    Encyption enabled on bucket a-test-bucket-in-us-west-1 with rules:
    {:apply_server_side_encryption_by_default=>{:sse_algorithm=>"AES256"}}
    $

Example of `s3-secure policy enforce_ssl`:

    $ s3-secure policy enforce_ssl a-test-bucket-in-us-west-1
    Add bucket policy to bucket a-test-bucket-in-us-west-1:
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "ForceSSLOnlyAccess",
          "Effect": "Deny",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::a-test-bucket-in-us-west-1/*",
          "Condition": {
            "Bool": {
              "aws:SecureTransport": "false"
            }
          }
        }
      ]
    }
    $

When removing ssl enforcement from the bucket policy, if there are other policy statements, those are left in tact.  Example:

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

For more help:

    s3-secure -h
    s3-secure encryption -h
    s3-secure encryption enable -h
    s3-secure lifecycle -h
    s3-secure lifecycle add -h
    s3-secure policy -h
    s3-secure policy unforce_ssl -h
    s3-secure versioning -h
    s3-secure versioning enable -h

## Batch Commands

There are some supported batch commands:

    s3-secure batch encryption enable FILE.txt
    s3-secure batch encryption disable FILE.txt
    s3-secure batch policy enforce_ssl FILE.txt
    s3-secure batch policy unforce_ssl FILE.txt

The format of `FILE.txt` is a list of bucket names separated by newlines.  Example:

buckets.txt:

    my-bucket-1
    my-bucket-2

## Installation

Install with:

    gem install s3-secure