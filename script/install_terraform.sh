#!/bin/bash

mkdir terraform && cd terraform

if [ ! -x "$wget" ]; then
  echo "No wget, attempting installation" && \
  apt-get -qq update && \
  apt-get install -y wget
fi

wget "https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip?_ga=2.263138373.894661718.1499783053-363188929.1497437419" -O terraform.zip

if [ ! -x "$unzip" ]; then
  echo "No unzip, attempting installation" && \
  apt-get -qq update && \
  apt-get install -y unzip
fi

unzip terraform.zip
rm terraform.zip && cp terraform /usr/bin/ && rm terraform && cd ..

#Get a fresh copy of the code
git clone git@github.com:KomaNelson/terraform-test.git

cd terraform-resource/main && terraform plan
