# SETUP SSL CA Infrastructure
------------------------------

# Setup local CA authority

## Install local CA artifacts derived from [this](http://www.ulduzsoft.com/2012/01/creating-a-certificate-authority-and-signing-the-ssl-certificates-using-openssl/) and [this](http://acidx.net/wordpress/2012/09/creating-a-certification-authority-and-a-server-certificate-on-ubuntu/) work.

- Install openssl
- cd /opt/
- mkdir localCA
- create ca.conf
- cd localCA/
- mkdir -p certs private crl
- echo "01" > serial
- touch index.txt
- mkdir ../webIDESecurityInfra
- cd ..
- mv localCA/ ca.conf webIDESecurityInfra/
- cd webIDESecurityInfra/
- OPENSSL=ca.conf openssl req -x509 -nodes -days 3650  -newkey rsa:2048 -out ./certs/ca.pem -outform PEM -keyout ./private/ca.key

# Create server certificates using local CA authority

```openssl genrsa -out $PRIVATE_KEY 2048```

```openssl req -new -key $PRIVATE_KEY -config $OPENSSL_CONFIG -out $REQ```

```openssl ca -in $REQ -out $PUBLIC_KEY -config $LOCAL_CA_CONF```

# Add local CA to trusted CA list

- Use update-ca-certificates , or 
- ```certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n webide.io -i /opt/webIDESecurityInfra/certs/ca.pem```. Check this [doc](https://wiki.archlinux.org/index.php/Network_Security_Services) for more detail.

