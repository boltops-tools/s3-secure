# S3Bucket

[![Gem Version](https://badge.fury.io/rb/s3-bucket.png)](http://badge.fury.io/rb/s3-bucket)

The s3-bucket tool can be used to harden your s3 bucket security posture. It currently supports:

* enabling encryption
* adding an enforce ssl bucket policy.

## Usage

You can use the list subcommands to list the current settings.

    s3-bucket list encryption
    s3-bucket list policy

Then you can enable encryption or add an bucket policy to ensure that https is used to access s3 urls.

    s3-bucket enable encryption BUCKET
    s3-bucket enable ensure-https BUCKET

To enable multiple buckets use the `enable-all` command:

    s3-bucket enable-all encryption FILE
    s3-bucket enable-all ensure-https FILE

## Installation

Install with the `gem` command:

    gem install s3-bucket

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
