## Examples

    s3-secure completion

Prints words for TAB auto-completion.

    s3-secure completion
    s3-secure completion hello
    s3-secure completion hello name

To enable, TAB auto-completion add the following to your profile:

    eval $(s3-secure completion_script)

Auto-completion example usage:

    s3-secure [TAB]
    s3-secure hello [TAB]
    s3-secure hello name [TAB]
    s3-secure hello name --[TAB]
