# S3Secure

[![Gem Version](https://badge.fury.io/rb/s3-secure.png)](http://badge.fury.io/rb/s3-secure)

The s3-secure tool can be used to harden your s3 bucket security posture. It currently supports:

* enabling encryption
* adding an enforce ssl bucket policy.

## Usage

Summary of encryption commands:

    s3-secure encryption list
    s3-secure encryption show BUCKET
    s3-secure encryption enable BUCKET
    s3-secure encryption disable BUCKET

Summary of policy commands:

    s3-secure policy list
    s3-secure policy show BUCKET
    s3-secure policy enable-https BUCKET
    s3-secure policy disable-https BUCKET

## Batch Commands

There are some batch commands:

    s3-secure encryption batch enable FILE.txt
    s3-secure encryption batch disable FILE.txt
    s3-secure policy batch enable-https FILE.txt
    s3-secure policy batch disable-https FILE.txt

The format of FILE.txt is a list of bucket names separated by newlines.  Example:

buckets.txt:

    my-bucket-1
    my-bucket-2

## Installation

Install with the `gem` command:

    gem install s3-secure

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
