#!/bin/bash
set -e
# Define environment variables
SERVICE_PRINCIPAL_APP_ID="<your-service-principal-app-id>"
SERVICE_PRINCIPAL_SECRET="<your-service-principal-password>"
TENANT_ID="<your-tenant-id>"
ENV_NAME="YOUR_ENV_NAME"
REGION="YOUR_REGION"
CURRENCY="YOUR_CURRENCY"
LANGUAGE="YOUR_LANGUAGE"

# Login to Power Apps using service principal
pac auth create --applicationId $SERVICE_PRINCIPAL_APP_ID \
    --clientSecret $SERVICE_PRINCIPAL_SECRET \
    --tenant $TENANT_ID

# Create a new environment
pac admin create --name $ENV_NAME --region $REGION \
    --currency $CURRENCY --language $LANGUAGE --type Production

rawOutput=$(pac admin list --name dev-us_XXX_Y | tail -n 2)
environmentId=$(echo $rawOutput | cut -d ' ' -f 2)

# Enable managed environment
pac admin set-governance-config \
   --environment $environmentId \
   --protection-level Standard