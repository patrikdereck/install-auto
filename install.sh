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
docker run -e TZ="America/Sao_Paulo" --name redis-izing -p 6379:6379 -d --restart=always redis:latest redis-server --appendonly yes --requirepass "password"
docker run --name postgresql -e POSTGRES_USER=izing -e POSTGRES_PASSWORD=password -p 5432:5432 -v /data:/var/lib/postgresql/data -d postgres
cd ~
wget https://github.com/LuisFlavio33/izing.io/archive/refs/heads/beta.zip
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
npm install
npm run build
docker stop $(docker ps -aq)
docker start $(docker ps -aq)
npx sequelize db:migrate
npx sequelize db:seed:all
npm install -g pm2
sleep 3s
pm2 start dist/server.js --name izing-backend
pm2 startup ubuntu -u root
env PATH=$PATH:/usr/bin pm2 startup ubuntu -u root --hp /var/www/html
cd /var/www/html/izing.io/frontend
nano /var/www/html/izing.io/frontend/.env
npm i -g @quasar/cli
sleep 3s
npm install
quasar build -P -m pwa
cd /var/www/html/izing.io/admin-frontend
npm install
npm run lint
quasar build
apt install nginx -y
sudo rm /etc/nginx/sites-enabled/default
mv /root/izing-backend /etc/nginx/sites-available/izing-backend
echo -e "\033[92m SELECIONE SEU SUB DO \033[6;7;93m BACKEND! \033[m"
sleep 5s
sudo nano /etc/nginx/sites-available/izing-backend
cd ~
mv /root/izing-frontend /etc/nginx/sites-available/izing-frontend
echo -e "\033[92m SELECIONE SEU SUB DO \033[6;7;93m FRONTEND! \033[m"
sleep 5s
sudo nano /etc/nginx/sites-available/izing-frontend
mv /root/izing-site /etc/nginx/sites-available/izing-site
echo -e "\033[92m SELECIONE SEU SUB DO \033[6;7;93m SITE! \033[m"
sleep 5s
sudo nano /etc/nginx/sites-available/izing-site
mv /root/izing-admin /etc/nginx/sites-available/izing-admin
echo -e "\033[92m SELECIONE SEU SUB DO \033[6;7;93m ADMIN! \033[m"
sleep 5s
sudo nano /etc/nginx/sites-available/izing-admin
cd /var/www/html
git clone https://github.com/n8n-io/n8n.git
cd /var/www/html/n8n
npm install sqlite3@5.1.2
npm install n8n@latest -g --force
pm2 start n8n
pm2 save
mv /root/izing-n8n /etc/nginx/sites-available/izing-n8n
echo -e "\033[92m SELECIONE SEU SUB DO \033[6;7;93m N8N! \033[m"
sleep 7s
nano /etc/nginx/sites-available/izing-n8n
cd /var/www/html/
git clone https://github.com/LuisFlavio33/baileyrs.git
cd /var/www/html/baileyrs/
npm install
pm2 start npm --name app.js -- start
pm2 save --force
mv /root/izing-bot /etc/nginx/sites-available/izing-bot
echo -e "\033[92m SELECIONE SEU SUB API \033[6;7;93m BOT BAILEYRS(qrCode) \033[m"
sleep 7s
nano /etc/nginx/sites-available/izing-bot
ln -s /etc/nginx/sites-available/izing-n8n /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/izing-backend /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/izing-frontend /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/izing-site /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/izing-admin /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/izing-bot /etc/nginx/sites-enabled
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
docker container start postgresql
docker update --restart unless-stopped $(docker ps -q)
pm2 startup
echo -e "\033[3;1;5;92m INSTALAÇÃO FINALIZADA COM SUCESSO! \033[0m"