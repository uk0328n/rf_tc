#!/bin/sh
MYHOME=/home/vagrant
MYSQL_PASSWORD=system
apt-get update

sudo -u vagrant cat > ${MYHOME}/.bash_login <<'EOF'
PATH=${PATH}:${HOME}/.gem/ruby/2.3.0/bin
screen -rx
EOF

sudo -u vagrant cat > ${MYHOME}/.gemrc <<EOF
install: --no-document --user-install
update: --no-document
EOF

sudo -u vagrant cat > ${MYHOME}/.railsrc <<EOF
--skip-test
EOF

apt-get -y install screen
sudo -u vagrant cat > ${MYHOME}/.screenrc <<EOF
escape ^t^t
termcapinfo xterm* ti@:te@
defscrollback 65536
EOF

echo "mysql-server-5.7 mysql-server/root_password password ${MYSQL_PASSWORD}" | debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password ${MYSQL_PASSWORD}" | debconf-set-selections
apt-get -y install mysql-server libmysqlclient-dev
sed -i -e 's/\(bind-address\s*= \).*/\10.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql.service
mysql -u root -p -e "grant all on *.* to root@'%' identified by 'system'"

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get -y install yarn

apt-get -y install build-essential
apt-get -y install ruby ruby-dev

sudo -iu vagrant <<EOF
cd ${MYHOME}/webroot
gem install bundle
bundle install
yarn install
EOF

apt-get install npm
npm install
