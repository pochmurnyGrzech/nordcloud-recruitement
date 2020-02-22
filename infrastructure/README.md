# Terraform readme

## First deployment

1. Prepare Azure credentials for your terraform. I recommend using Azure Service Principal instead of your private account.

2. Prepare Storage Account for Terraform Backend. Run script: `create_terraform_storage.sh`.

3. Initialize new workspace (or select existing one), which should depend on the environment which you already are working on (lab, dev, test or prod).

> terraform workspace new/select <provide_name_from_listed_above>

4. Validate files:

> terraform validate

5. Start deployment using:

> terraform apply --var-file=<workspace_name>.tfvars.json -target=azurerm_app_service.app_notejam

6. Provide login and password which you want to set up to your PostgreSQL server.

7. Check what will be deployed with current state and terraform files and if everything is OK, write `yes` and hit `enter`.

8. After successful deployment, you can deploy the rest of the architecture components:

> terraform apply --var-file=<workspace_name>.tfvars.json

9. Now you architecture should be ready for code deployment.
