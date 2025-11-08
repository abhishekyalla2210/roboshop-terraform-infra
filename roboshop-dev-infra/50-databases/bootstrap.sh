#!/bin/bash

dnf install ansible -y
ansible-pull -U https://github.com/abhishekyalla2210/terraforms.git \
             -d ~/roboshop-dev-infra \
             -e component=mongodb 
             main.yaml
