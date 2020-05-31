## Examples

    $ s3-secure lifecycle show a-test-bucket-in-us-east-1
    This S3 bucket has lifecycle rules
    Bucket lifecycle details:
    {:rules=>
      [{:expiration=>{:expired_object_delete_marker=>true},
        :id=>"s3-secure-automated-cleanup",
        :prefix=>"/bar",
        :status=>"Enabled",
        :noncurrent_version_expiration=>{:noncurrent_days=>365},
        :abort_incomplete_multipart_upload=>{:days_after_initiation=>30}}]}
    $