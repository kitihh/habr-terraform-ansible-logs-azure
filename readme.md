# SSH Login Monitoring with Grafana Loki

This repository contains infrastructure and configuration code to set up SSH login monitoring with notifications using Grafana Loki. This is an Azure Cloud adaptation of the original learning tutorial ["Ansible + Grafana Loki: Настраиваем отправку уведомлений в чат после логина на сервер по SSH"](https://habr.com/ru/articles/795855/) which was initially written for Yandex Cloud.

## Project Overview

This project sets up a monitoring system that:
1. Tracks SSH logins on your servers
2. Aggregates logs using Loki
3. Visualizes data with Grafana
4. Sends notifications to a chat when someone logs into your servers

### Components:
- **Terraform**: Deploys infrastructure in Azure (adapted from original Yandex Cloud configuration)
- **Ansible**: Configures servers and installs required software
- **Grafana**: Visualization and alerting
- **Loki**: Log aggregation system
- **Promtail**: Log collection agent for servers

## Infrastructure Setup

### Terraform Configuration
Deploys in Azure:
- 1 server for Grafana + Loki
- 3 monitored nodes with Promtail
- Required networking components
- Security groups for access control

### Ansible Configuration
Configures:
- Loki installation and setup on the main server
- Grafana installation and configuration
- Promtail deployment on monitored nodes
- Log shipping configuration
- Alert rules for SSH logins

## Prerequisites

- Azure subscription
- Terraform installed
- Ansible installed
- SSH key pair
- Azure CLI installed

## Usage

### 1. Infrastructure Deployment
```bash
# Login to Azure
az login

# Create Service Principal
az ad sp create-for-rbac --name "TerraformSP" --role Contributor --scopes "/subscriptions/YOUR_SUBSCRIPTION_ID"

# Deploy infrastructure
terraform init
terraform plan
terraform apply
```

### 2. Server Configuration
```bash
# Run Ansible playbook
ansible-playbook -i inventory.yml main.yml
```

## Extended Monitoring

While this setup focuses on SSH login monitoring, you can extend it to include:
- Server performance monitoring with Node Exporter
- Prometheus integration for metrics collection
- Additional log sources and alerts
- Custom dashboards for various metrics

## Original Article

This project is based on the article ["Ansible + Grafana Loki: Настраиваем отправку уведомлений в чат после логина на сервер по SSH"](https://habr.com/ru/articles/795855/). The main differences are:
- Use of Azure instead of Yandex Cloud
- Updated Terraform configurations for Azure resources
- Modified networking setup for Azure environment

## Project Structure
```
.
├── terraform/            # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── ansible/             # Server configuration
│   ├── inventory.yml
│   ├── main.yml
│   └── roles/
└── README.md
```

## Configuration Tips

### Grafana
- Default port: 3000
- Configure datasources for Loki
- Set up alert channels for notifications

### Loki
- Configure retention periods
- Set up log aggregation rules
- Define alert rules for SSH events

### Promtail
- Configure log scraping rules
- Set up log shipping to Loki
- Define log parsing rules

## Security Considerations

- All servers use SSH key authentication
- Network security groups restrict access
- Monitoring system tracks all login attempts
- Consider implementing additional security measures for production use

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

Special thanks to the author of the original article for the comprehensive tutorial that this project is based on.