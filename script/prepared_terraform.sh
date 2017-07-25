#!/bin/bash

cd terraform-resource/main/ && pwd
echo $PATH
echo " printing bin below" && ls -ahl /usr/bin/
ls -ahl && terraform plan
