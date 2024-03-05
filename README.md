# 14f3v.ss-ssl
ss-ssl is a command-line tool that generates self-signed SSL certificates based on the openssl library. Please allow yourself to join as a contributor to making it nicer.


## Usage

Download a script via curl and run a script.


```bash
curl -sL https://raw.githubusercontent.com/14f3v/14f3v.ss-ssl/main/run.sh | bash -s -- --domain "*.example.com" --outdir ./certificates

```

## Options

1. **--domain**: This parameter specifies the domain name for which the SSL certificate will be generated. You can provide a **wildcard (*)** to generate a certificate for multiple subdomains under the specified domain. For example, **--domain "*.example.com"** will generate a certificate for all subdomains of example.com.

2. **--outdir**: This parameter specifies the output directory where the SSL certificate files will be generated. If not specified, the script will use the default directory **./selfsign-ssl**. You can provide a custom directory path. For example, **--outdir ./certificates** will generate the certificate files in the certificates directory.


## Support

Currently only support for Ubuntu or [Debian distribution](https://www.debian.org/doc/manuals/debian-faq/basic-defs.en.html#:~:text=Debian%20GNU%2FLinux%20is%20a,a%20tool%20for%20this%20purpose.)
