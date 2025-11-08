#!/bin/bash

dnf install ansible -y
ansible-pull -u https://github.com/abhishekyalla2210/terraforms.git -e component=mongodb main.yaml