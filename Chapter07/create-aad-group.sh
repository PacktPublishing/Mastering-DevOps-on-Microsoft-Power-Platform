#!/bin/bash

# Variables
SERVICE_PRINCIPAL_APP_ID="<your-service-principal-app-id>"
SERVICE_PRINCIPAL_PASSWORD="<your-service-principal-password>"
TENANT_ID="<your-tenant-id>"
GROUP_NAME="<your-group-name>"

# Login as the service principal
az login --service-principal -u $SERVICE_PRINCIPAL_APP_ID -p $SERVICE_PRINCIPAL_PASSWORD --tenant $TENANT_ID

# Create the AAD group
az ad group create --display-name $GROUP_NAME --mail-nickname $GROUP_NAME

# get the user object id
AADObjectID=$(az ad user show \
             --id $userPrincipalName \
             --query id \
             --output tsv)

# add a member to the group
az ad group member add --group $GROUP_NAME --member-id $AADObjectID
