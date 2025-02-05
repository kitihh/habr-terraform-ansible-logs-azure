#!/bin/bash
echo "ssh_public_key = \"$(cat ~/.ssh/id_rsa.pub)\"" > terraform.tfvars