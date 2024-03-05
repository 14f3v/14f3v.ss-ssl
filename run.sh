#!/bin/sh
domainname=""
filetype=""
outdir="./selfsign-ssl"

function installOpenSSL() {
    echo "- installing openssl..."
    sudo apt-get install openssl
    echo "- installing openssl done..."
}

function checkingOpenSSLInstallation() {

   if [ -x "$(command -v openssl)" ]; then
      echo "- openssl installed"
   else

      echo "- Could not find openssl installation"
      echo -n "- Would you like to install openssl?: [Y/N] "
      read needToInstallOpenSSL

      if [[ $needToInstallOpenSSL ]]; then

         if [[ $needToInstallOpenSSL == "Y" || $needToInstallOpenSSL == "y" ]]; then
            installOpenSSL
         else
            echo "- Please install openssl in your working echo-system"
            exit
         fi

      else
         echo "- process exited..."
      fi

   fi
}

function genCert() {

    # Check if destination directory exists, if not create it
    if [ ! -d "$outdir" ]; then
        mkdir -p "$outdir"
    fi

    openssl req -newkey rsa:2048 -nodes -keyout $outdir/privatekey.pem -x509 -days 365 -out $outdir/certificate.pem -subj "/CN=$domainname"
    -addext "subjectAltName=DNS:$domainname" \
    -addext "basicConstraints=critical,CA:TRUE,pathlen:0" \
    -addext "keyUsage=critical,keyCertSign,cRLSign,digitalSignature"

    openssl verify -CAfile $outdir/certificate.pem -verify_hostname $domainname $outdir/certificate.pem
}

# Iterate through the arguments provided
while [ "$1" != "" ]; do
   case $1 in
      --domain )
         shift
         domainname=$1
         ;;
      --outdir )
         shift
         outdir=$1
         ;;
      * )
         # Handle invalid argument
         echo "Invalid argument: $1"
         exit 1
         ;;
   esac
   shift
done

# Check if domainname and filetype are provided
if [ "$domainname" = "" ]; then
    echo "Usage: $0 --domain <domain_name>"
    exit 1
fi

checkingOpenSSLInstallation
genCert
