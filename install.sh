#/bin/bash
dpkg-reconfigure tzdata
apt update &&  apt upgrade -y
apt install apt-transport-https ca-certificates curl software-properties-common -y
add-apt-repository -y ppa:rabbitmq/rabbitmq-erlang
wget -qO - https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.deb.sh |  bash
apt install -y rabbitmq-server
rabbitmq-plugins enable rabbitmq_management
rabbitmqctl add_user admin 123456
rabbitmqctl set_user_tags admin administrator
rabbitmqctl set_permissions -p / admin "." "." ".*"
apt-get install -y libgbm-dev wget docker.io chromium-browser unzip fontconfig locales gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils
apt-add-repository universe
apt update 
apt install python2-minimal -y
apt-get install build-essential -y
docker run -e TZ="America/Sao_Paulo" --name redis-izing -p 6379:6379 -d --restart=always redis:latest redis-server --appendonly yes --requirepass "izing1551"
docker run --name izing -e POSTGRES_USER=izing -e POSTGRES_PASSWORD=izing1551 -p 5432:5432 -v /data:/var/lib/postgresql/data -d postgres
cd ~
wget https://github.com/patrikdereck/izing.io/archive/refs/heads/beta.zip
unzip beta.zip
mkdir /var/www
mkdir /var/www/html
mv /root/izing.io-beta /var/www/html/izing.io
chmod 777 -R /var/www/html/izing.io
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb 
apt install curl 
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
apt-get install -y nodejs
cd /var/www/html/izing.io/backend/
nano /var/www/html/izing.io/backend/.env
npm install @types/express-serve-static-core@4.17.20 --save-dev
npm uninstall @types/ioredis --save-dev
npm install ioredis@5.2.4 --save
npm run build
docker stop $(docker ps -aq)
docker start $(docker ps -aq)
npx sequelize db:migrate
npx sequelize db:seed:all
npm install -g pm2
sleep 3s
pm2 start dist/server.js --name BACKEND
pm2 startup ubuntu -u root
env PATH=$PATH:/usr/bin pm2 startup ubuntu -u root --hp /var/www/html
cd /var/www/html/izing.io/frontend
nano /var/www/html/izing.io/frontend/.env
npm i -g @quasar/cli
sleep 3s
npm install
quasar build -P -m pwa
apt install nginx -y
sudo rm /etc/nginx/sites-enabled/default
mv /root/backend /etc/nginx/sites-available/backend
echo -e "\033[92m SELECIONE SEU SUB DO \033[6;7;93m BACKEND! \033[m"
sleep 5s
sudo nano /etc/nginx/sites-available/backend
cd ~
mv /root/frontend /etc/nginx/sites-available/frontend
echo -e "\033[92m SELECIONE SEU SUB DO \033[6;7;93m FRONTEND! \033[m"
sleep 5s
sudo nano /etc/nginx/sites-available/frontend
sleep 5s
ln -s /etc/nginx/sites-available/backend /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/frontend /etc/nginx/sites-enabled
echo -e "\033[3;1;3;92m IMPORTANTE copie a linha abaixo e cole abaixo de BASIC... no arquivo que abrira a seguir \033[92m \nclient_max_body_size 50M; \033[0m"
sleep 20s
nano /etc/nginx/nginx.conf
apt install snapd -y
nginx -t
service nginx restart
snap install --classic certbot
echo -e  "\033[92m ASSINE SEU SSL PELO MENOS DO \033[6;7;93m BACK E DO FRONT! \033[m"
sleep 7s
certbot --nginx
docker container start chatvi
docker update --restart unless-stopped $(docker ps -q)
pm2 startup
echo -e "\033[3;1;5;92m INSTALAÇÃO FINALIZADA COM SUCESSO! \033[0m"
