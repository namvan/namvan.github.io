# Display all environment variables from a running PowerShell script
`gci env:* | sort-object name`

## Avoid truncation of environment variables
`gci env: | Format-Table -Wrap -AutoSize`

## Convert .pfx certificate to Base64 encoded string
`$pfx_cert = get-content 'certificate.pfx' -Encoding Byte`

`$base64 = [System.Convert]::ToBase64String($pfx_cert)`