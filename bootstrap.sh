#!/bin/bash

# This scripts bootstraps the .env file for seatplus on docker to work

# first check if .env already exists and exit if so

if [ -f .env ]; then
    echo "Seems like you bootstrapped your .env already, exiting ..."
    exit 1
fi

#copy the .env file
cp .env.example .env

echo "Setup SeAT plus"
# change the DB_PASSWORD
sed -i -- 's/DB_PASSWORD=i_should_be_changed/DB_PASSWORD='$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c22 ; echo '')'/g' .env

URL = ''

while [[ $(echo $URL | grep -c "https://") -eq 0  &&  $(echo $URL | grep -c "http://") -eq 0 ]]; do
    read -p "Please enter your applications URL (including http or https protocol) where your SeAT plus instance can be found from the Internet: " SUBMITTED_URL
        URL=${SUBMITTED_URL:-http://seatplus.test}
done

sed -i -- 's,APP_URL=url,APP_URL='"${URL}"',g' .env

# setup Host in docker-compose.prod.yml
URL_WITHOUT_PROTOCOL=${URL#*//}
sed 's/traefik.http.routers.seatplus_route.rule=.*/traefik.http.routers.seatplus_route.rule=Host(`'"$URL_WITHOUT_PROTOCOL"'`)"/g' -i docker-compose.prod.yml

echo    # (optional) move to a new line
echo "Setup EVE Online Application"
echo "Please go to https://developers.eveonline.com/applications/create in order to create a new application"

echo "You must use $URL/auth/eve/callback as callback"

sed -i -- 's,EVE_CALLBACK_URL=null,EVE_CALLBACK_URL='"${URL}"'/auth/eve/callback,g' .env

while [ -z "$CLIENT_ID" ]
do
  read -p "Client ID: " CLIENT_ID
done

while [ -z "$CLIENT_SECRET" ]
do
  read -p "Secret Key / Client Secret: " CLIENT_SECRET
done

sed -i -- 's/EVE_CLIENT_ID=null/EVE_CLIENT_ID='"${CLIENT_ID}"'/g' .env
sed -i -- 's/EVE_CLIENT_SECRET=null/EVE_CLIENT_SECRET='"${CLIENT_SECRET}"'/g' .env

echo    # (optional) move to a new line
echo 'Everything is now setup for you ... up the containers'
echo 'If may edit the .env at any point in the future. Please note changes will only apply if you up the containers again.'