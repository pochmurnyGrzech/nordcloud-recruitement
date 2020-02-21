# Introduction

## Migration plan
For this task I recommend few steps of moving from on-prem evnironment to cloud. I choosed Azure Cloud, because I have more experience in using it.

### Step 1: Separete application and database (move DB from SQlite to PostgreSQL).

Azure App Service + Azure Database for PostgreSQL.

### Step 2: Divide application on backend and frontend code.

Frontend on Storage, Backend could be rewrite to Functions or stay on App Service.

### Step 4: Rethink tech stack

Move backend to TypeScript, work on code architecture more (divide application on layers: data provider repositories, business logic services, api views).

### Step 3: Utilize more cloud components.

- Azure Active Directory (B2C if client want to ) for user management
