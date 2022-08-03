sudo apt-get update
sudo apt-get -y upgrade

sudo apt-add-repository ppa:ondrej/php -y
sudo apt-get update

sudo apt-get install -y software-properties-common curl zip
sudo apt-get install -y php7.2-cli php7.2-fpm \
php7.2-pgsql php7.2-sqlite3 php7.2-gd \
php7.2-curl php7.2-memcached \
php7.2-imap php7.2-mysql php7.2-mbstring \
php7.2-xml php7.2-xmlrpc php7.2-json php7.2-zip php7.2-bcmath php7.2-soap \
php7.2-intl php7.2-readline php7.2-ldap

sudo apt-get install telnet

sudo apt-get install -y libapache2-mod-php
sudo apt-get install -y mysql-server
sudo apt-get install apache2

sudo apt-get install -y git

sudo apt-get install -y awscli
#docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo apt-get install -y nginx

rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

cat > /etc/nginx/sites-available/ubuntu-full <<EOF
server {
    listen 89;
    server_name .ubuntu-full.loc;
    root "/home/vagrant/code";

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/ubuntu-full-error.log error;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

ln -s /etc/nginx/sites-available/ubuntu-full /etc/nginx/sites-enabled/ubuntu-full

service nginx restart