# Known issues

1. Azure DevOps Pipeline defined in `azure-pipeline.yml` has hardcoded web app and environment names. It should come as an output from the infrastructure pipeline, which is missing here.

2. Code tests are still using SQLite database.

3. Before terraform usage there is a need to create storage for terraform backend. `create_terraform_storage.sh` script prepares resource group and storage account, but not blob container.

4. There is no chance to deploy all architecture using single `terraform apply` because of firewall rules. They should be in separated module.

5. Database replica isn't inside terraform code because is not supported by terraform right now. It could be done with ARM template deployment.

6. Because key vault is not in another module, providing login and password to the database is always necessary.

7. There is just one Azure Devops Pipeline for master branch. In proudction scenario there should be separated pipelines for infra and for code and for different environemnts, based on branch (develop - dev, master - prod, release - test etc.).