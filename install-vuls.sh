#!/bin/sh

# install golang
# =======================================
yum install -y wget
wget https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.6.2.linux-amd64.tar.gz

tee /etc/profile.d/goenv.sh <<-EOF
export GOROOT=/usr/local/go
export GOPATH=\$HOME/go
export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin
EOF

source /etc/profile.d/goenv.sh

tee /root/hello.go <<-EOF
package main
 
import "fmt"
 
func main() {
    fmt.Printf("hello world!!!\n")
}
EOF

go run /root/hello.go
# =======================================



yum install -y sqlite git gcc

mkdir -p /var/log/vuls
chown vagrant /var/log/vuls
chmod 700 /var/log/vuls

mkdir -p /root/vuls

tee /root/vuls/config.toml <<-EOF
[servers.127-0-0-1]
host    =       "127.0.0.1"
port    =       "22"
user    =       "vagrant"
keyPath =       "/home/vagrant/.ssh/id_rsa"
EOF

# install go-cve-dictionary
go get github.com/kotakanbe/go-cve-dictionary

# install vuls
go get github.com/future-architect/vuls

cd /root/vuls

# Fetch vulnerability data from NVD.
#go-cve-dictionary fetchjvn -entire
#go-cve-dictionary fetchjvn -month
go-cve-dictionary fetchjvn -week

# Setting up target servers for Vuls
vuls prepare

# Start Scanning
#vuls scan -cve-dictionary-dbpath=/root/vuls/cve.sqlite3
#vuls scan -lang=ja

# TUI
#vuls tui

