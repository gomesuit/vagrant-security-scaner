#!/bin/sh

yum install -y openssl-devel perl perl-Net-SSLeay perl-Crypt-SSLeay

wget https://cirt.net/nikto/nikto-2.1.5.tar.gz

tar xvfz nikto-2.1.5.tar.gz
mv nikto-2.1.5 /usr/local

cd /usr/local/nikto-2.1.5

perl ./nikto.pl -update

# example
# perl ./nikto.pl -h https://127.0.0.1
