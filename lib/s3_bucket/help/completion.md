## Examples

    s3-bucket completion

Prints words for TAB auto-completion.

    s3-bucket completion
    s3-bucket completion hello
    s3-bucket completion hello name

To enable, TAB auto-completion add the following to your profile:

    eval $(s3-bucket completion_script)

Auto-completion example usage:

    s3-bucket [TAB]
    s3-bucket hello [TAB]
    s3-bucket hello name [TAB]
    s3-bucket hello name --[TAB]
