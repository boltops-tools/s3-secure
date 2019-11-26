## Examples

    $ s3-secure summary
    Determining bucket security-related settings...
    +----------------------------+------+------------+
    |           Bucket           | SSL? | Encrypted? |
    +----------------------------+------+------------+
    | a-test-bucket-in-us-east-1 | yes  | no         |
    | a-test-bucket-in-us-west-1 | no   | no         |
    +----------------------------+------+------------+
    $

There are `--ssl no` and `--encrypted no` filtering options:

    $ s3-secure summary --ssl no --encrypted no
    Determining bucket security-related settings...
    +----------------------------+------+------------+
    |           Bucket           | SSL? | Encrypted? |
    +----------------------------+------+------------+
    | a-test-bucket-in-us-west-1 | no   | no         |
    +----------------------------+------+------------+
    $