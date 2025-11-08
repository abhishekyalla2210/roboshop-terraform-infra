#!/bin/bash

dnf install ansible -y
ansible-pull -u https://github.com/abhishekyalla2210/ansible-roboshop-roles-terraform.git -e component=mongodb main.yaml