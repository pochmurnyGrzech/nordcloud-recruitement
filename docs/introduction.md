# Introduction

## Migration plan
For this task I recommend few steps of moving from on-prem evnironment to cloud. I choosed Azure Cloud, because I have more experience in using it.

### Step 1: Without application code changes.

Azure App Service with Azure Web Job 

### Step 2: Separete application and database (move DB from SQlite to PostgreSQL).

Should be done as fast as it can. I highly recommend to start from this step.
Azure App Service + Azure Database for PostgreSQL.

### Step 3: Divide application on backend and frontend code.

Frontend could be done in 
Frontend on Storage, Backend could be rewrite to Functions or stay on App Service.

### Step 4: Utilize more cloud components.

- Azure Active Directory (B2C if client want to ) for user management
