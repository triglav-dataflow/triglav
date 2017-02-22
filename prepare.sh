#!/bin/sh

cp config/database.yml.development config/database.yml
cp config/settings.yml.development config/settings.yml
cp config/secrets.yml.development config/secrets.yml
cp db/seeds.rb.development db/seeds.rb
mkdir -p log
