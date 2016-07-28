#!/bin/sh

# install ruby

yum install -y git

git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
exec $SHELL -l

git clone git://github.com/sstephenson/ruby-build.git .rbenv/plugins/ruby-build

yum install -y gcc openssl-devel readline-devel zlib-devel

rbenv install 2.3.1
rbenv global 2.3.1

# ========================================


wget https://github.com/wpscanteam/wpscan/tarball/master
tar zxf master
cd wpscanteam-wpscan-d270391
gem install bundler
bundle install --without test development

# 侵入を試行しない単純なスキャン
# ruby wpscan.rb -u www.example.com

# ログインユーザ一覧の取得
# ruby wpscan.rb -u www.example.com -e u

# ログインパスワードのブルートフォースアタックと取得
# ruby wpscan.rb -u www.example.com -w password.txt -U admin –threads 10

# インストールされているプラグインの列挙とバージョンの取得
# ruby wpscan.rb -u www.example.com -e ap

# インストールされているテーマとバージョンの取得
# ruby wpscan.rb -u www.example.com -e at





# install docker
# curl -fsSL https://get.docker.com/ | sh
# curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
# chmod +x /usr/local/bin/docker-compose

tee /root/docker-compose.yml <<-EOF
version: '2'
services:
  db:
    image: mysql:5.7
    volumes:
      - "./.data/db:/var/lib/mysql"
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    links:
      - db
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_PASSWORD: wordpress
EOF
