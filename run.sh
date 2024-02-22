#!/bin/sh

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
      read needToInstallDocker

      if [[ $needToInstallDocker ]]; then

         if [[ $needToInstallDocker == "Y" || $needToInstallDocker == "y" ]]; then
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
    openssl req -newkey rsa:2048 -nodes -keyout ./selfsign-ssl/privatekey.pem -x509 -days 365 -out ./selfsign-ssl/certificate.pem -subj "/CN=$domainname"
    -addext "subjectAltName=DNS:$domainname" \
    -addext "basicConstraints=critical,CA:TRUE,pathlen:0" \
    -addext "keyUsage=critical,keyCertSign,cRLSign,digitalSignature"

    openssl verify -CAfile ./selfsign-ssl/certificate.pem -verify_hostname $domainname ./selfsign-ssl/certificate.pem
}

echo -n "- Enter your domainname?: Ex: [www.test.com/*.test.com/app.test.com]: "
read domainname
checkingOpenSSLInstallation
genCert
