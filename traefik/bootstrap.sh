#!/bin/bash

read -p "Please provide your valid email in order to receive SSL certificates: " EMAIL

sed 's/--certificatesresolvers.myresolver.acme.email=.*/--certificatesresolvers.myresolver.acme.email='"$EMAIL"'"/g' -i docker-compose.prod.yml