#!/bin/bash

cd terraform-resource/main/ && pwd
echo $PATH
ls -ahl && terraform plan
