# Grubber AWS Terraform Cloud Infrastructure

## Overview
This project provisions an AWS cloud infrastructure for a fictitious customer named Grubber using Terraform. It includes a VPC, S3 bucket, and a serverless AWS Lambda function triggered by S3 events.

## Features
- **Network Configuration**: Creates a VPC with public and private subnets, an internet gateway, and a NAT gateway.
- **Storage**: Sets up an S3 bucket with event notifications.
- **Serverless Function**: Deploys a Lambda function that processes newly uploaded S3 files.
- **Infrastructure as Code**: Utilizes Terraform modules for maintainability and reusability.

## Project Structure
```
terraform/
│── modules/
│   ├── vpc/
│   │   ├── vpc.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── s3/
│   │   ├── s3.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── lambda/
│   │   ├── lambda.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│── lambda_function/
│   ├── lambda_function.py
│── main.tf
│── variables.tf
│── outputs.tf
│── terraform.tfvars
│── README.md
```

## Setup Instructions
### Prerequisites
- Terraform installed
- AWS CLI configured with necessary permissions

### Steps to Deploy
1. Clone the repository:
   ```sh
   git clone <repository_url>
   cd cloud_infrastructure/aws/terraform
   ```
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Plan the infrastructure:
   ```sh
   terraform plan
   ```
4. Apply the configuration:
   ```sh
   terraform apply -auto-approve
   ```
5. Verify deployed resources in AWS Console.

### Cleanup
To destroy the infrastructure, run:
```sh
terraform destroy -auto-approve
```

## Terraform Modules
### VPC Module
Located in `modules/vpc/`, it provisions:
- A VPC
- Public and private subnets
- Internet and NAT gateways
- Uses `for_each` to manage multiple subnets dynamically

### S3 Module
Located in `modules/s3/`, it provisions:
- An S3 bucket
- Event notification for Lambda

### Lambda Module
Located in `modules/lambda/`, it provisions:
- A Lambda function with an IAM execution role
- S3 event trigger
- Uses `for_each` for multiple function deployments if needed

## Configuration Variables
Define custom values in `terraform.tfvars`. See sample below for minimum required config:
```hcl
#------------------------------------------------------------------------------
# Access
#------------------------------------------------------------------------------
region     = "us-east-1"
access_key = ""
secret_key = ""

#------------------------------------------------------------------------------
# AWS Virtual Private Network (VPC)
#------------------------------------------------------------------------------

cidr_block = ""

private_subnets = {
  gb_subnet = {
    availability_zone = ""
    cidr_block        = ""
  }
}

private_subnets_additional_tags = {
  TEAM_NAME = "",
  CREATION_DATE = "",
}

public_subnets = {
  gb_subnet = {
    availability_zone = ""
    cidr_block        = ""
  }
}

public_subnets_additional_tags = {
  TEAM_NAME = "",
  CREATION_DATE = "",
}

s3_buckets = {
  "bucket1" = { name = "" }
}

lambda_function_name = ""
```

## Outputs
Run `terraform output` to retrieve specified outputs

## Further enhancements and Notes
- Analyze IAM policies for tighter scope and least privilege best practice
- Use KMS encryption instead of the default SSE

