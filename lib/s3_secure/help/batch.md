There are some supported batch commands:

    s3-secure batch encryption enable FILE.txt
    s3-secure batch encryption disable FILE.txt
    s3-secure batch policy enforce_ssl FILE.txt
    s3-secure batch policy unforce_ssl FILE.txt

The format of FILE.txt is a list of bucket names separated by newlines.  Example:

buckets.txt:

    my-bucket-1
    my-bucket-2

