## Examples

    $ s3-secure lifecycle list
    +----------------------------+----------------------+
    |           Bucket           | Has Lifecycle Rules? |
    +----------------------------+----------------------+
    | a-test-bucket-in-us-east-1 | false                |
    | a-test-bucket-in-us-west-1 | true                 |
    +----------------------------+----------------------+
    $ s3-secure lifecycle list --lifecycle true
    +----------------------------+----------------------+
    |           Bucket           | Has Lifecycle Rules? |
    +----------------------------+----------------------+
    | a-test-bucket-in-us-west-1 | true                 |
    +----------------------------+----------------------+
    $ s3-secure lifecycle list --lifecycle false
    +----------------------------+----------------------+
    |           Bucket           | Has Lifecycle Rules? |
    +----------------------------+----------------------+
    | a-test-bucket-in-us-east-1 | false                |
    +----------------------------+----------------------+
    $