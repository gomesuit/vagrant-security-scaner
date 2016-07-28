#!/bin/sh

yum install -y wget
yum install -y libidn-devel gcc openssl-devel

wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/skipfish/skipfish-2.10b.tgz
tar zxf skipfish-2.10b.tgz
cd skipfish-2.10b/
make

./skipfish --help
