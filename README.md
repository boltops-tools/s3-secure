# S3Bucket

[![Gem Version](https://badge.fury.io/rb/s3-bucket.png)](http://badge.fury.io/rb/s3-bucket)

The s3-bucket tool can be used to harden your s3 bucket security posture. It currently supports:

* enabling encryption
* adding an enforce ssl bucket policy.

## Usage

Summary of encryption commands:

    s3-bucket encryption list
    s3-bucket encryption show BUCKET
    s3-bucket encryption enable BUCKET
    s3-bucket encryption disable BUCKET

Summary of policy commands:

    s3-bucket policy list
    s3-bucket policy show BUCKET
    s3-bucket policy enable-https BUCKET
    s3-bucket policy disable-https BUCKET

## Batch Commands

There are some batch commands:

    s3-bucket encryption batch enable FILE.txt
    s3-bucket encryption batch disable FILE.txt
    s3-bucket policy batch enable-https FILE.txt
    s3-bucket policy batch disable-https FILE.txt

The format of FILE.txt is a list of bucket names separated by newlines.  Example:

buckets.txt:

    my-bucket-1
    my-bucket-2

## Installation

Install with the `gem` command:

    gem install s3-bucket

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
