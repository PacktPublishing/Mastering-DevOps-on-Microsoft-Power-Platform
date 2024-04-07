#!/bin/bash

# Variables
SERVICE_PRINCIPAL_APP_ID="<your-service-principal-app-id>"
SERVICE_PRINCIPAL_SECRET="<your-service-principal-password>"
TENANT_ID="<your-tenant-id>"

projectName="Your Project Name"
organization="Your Organization"
organizationURL="https://dev.azure.com/$organization"
aadAdminGroupName="Your AAD Group Name"
PAT="<your-personal-access-token>"

echo $PAT | az devops login --organization $organizationURL
# Create a new Azure DevOps project
az devops project create --name $projectName --org $organizationURL
# Login to Microsoft Azure
az login --service-principal -u $SERVICE_PRINCIPAL_APP_ID -p $SERVICE_PRINCIPAL_SECRET --tenant $TENANT_ID
# Get the ID of the AAD group
aadAdminGroupId=$(az ad group show --group $aadAdminGroupName --query id -o tsv)
# Get the ID of the Azure DevOps Administrators and Contributors groups
azureDevopsAdminGroupDescriptor=$(az devops security group list --organization $organizationURL --project $projectName | jq -r '.graphGroups[] | select(.displayName=="Project Administrators") | .descriptor')
azureDevopContributorGroupDescriptor=$(az devops security group list --organization $organizationURL project --project $projectName | jq -r '.graphGroups[] | select(.displayName=="Contributors") | .descriptor')

# Add the AAD group to the Administrators and Contributors groups in Azure DevOps
# az devops security group membership add --group-id $azureDevopsAdminGroupId --member-id $aadAdminGroupId --org $(System.CollectionUri)
# it doesn't work because
# https://github.com/Azure/azure-devops-cli-extension/issues/667

# https://developercommunity.visualstudio.com/t/can-not-get-aad-group-from-azure-devops-cli/1493242
curl -u :$PAT \
     -H "Content-Type: application/json" \
     -d "{\"originId\": \"$aadAdminGroupId\"}" \
     "https://vssps.dev.azure.com/{organization}/_apis/graph/groups?groupDescriptors=$azureDevopsAdminGroupDescriptor&api-version=6.1-preview.1"


#az devops security group membership add --group-id $aadAdminGroupId --member-id $azureDevopContributorGroupId