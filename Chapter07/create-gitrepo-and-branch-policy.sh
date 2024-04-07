#!/bin/bash

# Variables
organizationURL="<Your-Azure-DevOps-Organization-URL>"
project="<Your-Azure-DevOps-Project>"
repository="<Your-New-Repository-Name>"
pat="<Your-Personal-Access-Token>"

# Create a new repository
echo "Creating new repository..."
repositoryId=$(az repos create --name $repository --organization $organizationURL --project $project --detect false | jq -r .id)

# initialize the repository git commands (az repos create doesn't support this)
organizationName=$(basename $organizationURL)
git clone https://$organizationName@dev.azure.com/$organizationName/$project/_git/$repository
cd $repository
git checkout -b main
echo "# $repository" >> README.md
git add .
git commit -m "Initial commit"
git push -u origin --all

# Set branch policy
echo "Setting branch policy..."
az repos policy work-item-linking create --branch "refs/heads/main" \
    --enabled true --organization $organization --project $project \
    --repository $repositoryId --blocking true --detect false

echo "Done."