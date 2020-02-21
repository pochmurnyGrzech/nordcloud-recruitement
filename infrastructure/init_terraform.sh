az group create \
    --name rg0terraform0we \
    --location westeurope

az storage account create \
    --name st0terraformbackend0we\
    --resource-group rg0terraform0we \
    --location westeurope \
    --sku Standard_ZRS \
    --encryption blob

az storage container create --name tfstate